import { useState } from 'react';
import { Button, Input, Section, Stack, Tabs } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type PhoneData = {
  availability: number;
  last_caller: string;
  available_transmitters: string[];
  transmitters: TransmittersData[];
};

type TransmittersData = {
  phone_category: string;
  phone_color: string;
  phone_name: string;
  phone_id: string;
  phone_icon: string;
};

export const PhoneMenu = (props) => {
  return (
    <Window width={500} height={400}>
      <Window.Content>
        <GeneralPanel />
      </Window.Content>
    </Window>
  );
};

const GeneralPanel = (props) => {
  const { act, data } = useBackend<PhoneData>();
  const { availability, last_caller } = data;
  const available_transmitters = Object.keys(data.available_transmitters);
  const transmitters = data.transmitters.filter((val1) =>
    available_transmitters.includes(val1.phone_id),
  );
  transmitters.sort((a, b) => {
    if (a.phone_name < b.phone_name) {
      return -1;
    }
    if (a.phone_name > b.phone_name) {
      return 1;
    }
    return 0;
  });

  const categories: string[] = [];
  for (let i = 0; i < transmitters.length; i++) {
    let transmitter_data = transmitters[i];
    if (categories.includes(transmitter_data.phone_category)) continue;

    categories.push(transmitter_data.phone_category);
  }
  categories.sort();

  const [currentSearch, setSearch] = useState('');
  const [selectedPhone, setSelectedPhone] = useState(null);
  const [currentCategory, setCategory] = useState(categories[0]);

  let dnd_tooltip = 'Do Not Disturb is DISABLED';
  let dnd_locked = 'No';
  let dnd_icon = 'volume-high';
  let dnd_color = 'green';
  switch (availability) {
    case 1:
      dnd_tooltip = 'Do Not Disturb is ENABLED';
      dnd_icon = 'volume-xmark';
      dnd_color = 'red';
      break;
    case 2:
      dnd_tooltip = 'Do Not Disturb is ENABLED (Only Public Phones)';
      dnd_color = 'blue';
      break;
    case 3:
      dnd_tooltip = 'Do Not Disturb is ENABLED (LOCKED)';
      dnd_locked = 'Yes';
      dnd_icon = 'volume-xmark';
      dnd_color = 'red';
      break;
    case -1:
      dnd_tooltip = 'Do Not Disturb is DISABLED (LOCKED)';
      dnd_locked = 'Yes';
      dnd_color = 'green';
      break;
  }

  return (
    <Section fill>
      <Stack vertical fill>
        <Stack.Item>
          <Tabs>
            {categories.map((val) => (
              <Tabs.Tab
                selected={val === currentCategory}
                onClick={() => setCategory(val)}
                key={val}
              >
                {val}
              </Tabs.Tab>
            ))}
          </Tabs>
        </Stack.Item>
        <Stack.Item>
          <Input
            fluid
            value={currentSearch}
            placeholder="Search for a phone"
            onInput={(e, value) => setSearch(value.toLowerCase())}
          />
        </Stack.Item>
        <Stack.Item grow>
          <Section fill scrollable>
            <Tabs vertical>
              {transmitters.map((val) => {
                if (
                  val.phone_category !== currentCategory ||
                  !val.phone_name.toLowerCase().match(currentSearch)
                ) {
                  return;
                }
                return (
                  <Tabs.Tab
                    selected={selectedPhone === val.phone_id}
                    onClick={() => {
                      if (selectedPhone === val.phone_id) {
                        act('call_phone', { phone_id: selectedPhone });
                      } else {
                        setSelectedPhone(val.phone_id);
                      }
                    }}
                    key={val.phone_id}
                    color={val.phone_color}
                    icon={val.phone_icon}
                  >
                    {val.phone_name}
                  </Tabs.Tab>
                );
              })}
            </Tabs>
          </Section>
        </Stack.Item>
        {!!selectedPhone && (
          <Stack.Item>
            <Button
              color="good"
              fluid
              textAlign="center"
              onClick={() => act('call_phone', { phone_id: selectedPhone })}
            >
              Dial
            </Button>
          </Stack.Item>
        )}
        {!!last_caller && <Stack.Item>Last Caller: {last_caller}</Stack.Item>}
        <Stack.Item>
          <Button
            color={dnd_color}
            tooltip={dnd_tooltip}
            disabled={dnd_locked === 'Yes'}
            icon={dnd_icon}
            fluid
            textAlign="center"
            onClick={() => act('toggle_dnd')}
          >
            Do Not Disturb
          </Button>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
