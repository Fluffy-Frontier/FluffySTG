import { Section, Stack } from 'tgui-core/components';
import { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import {
  Objective,
  ObjectivePrintout,
  ReplaceObjectivesButton,
} from './common/Objectives';

const hematocrat_name = {
  color: 'red',
};

type HematocratInfo = {
  objectives: Objective[];
  can_change_objective: BooleanLike;
};

export const AntagInfoHematocrat = (props) => {
  const { data } = useBackend<HematocratInfo>();
  const { objectives, can_change_objective } = data;
  return (
    <Window width={550} height={450} theme="ntos_spooky">
      <Window.Content>
        <Section scrollable fill>
          <Stack vertical textColor="red">
            <Stack.Item textAlign="center" fontSize="20px">
              You are a skilled surgeon and a flesh creator.
              <br />A <span style={hematocrat_name}> HEMATOCRAT</span>!
            </Stack.Item>
            <Stack.Item textAlign="center" italic>
              My power gives me control over others and my own lives, and
              sometimes control over items.
            </Stack.Item>
            <Section fill>
              You are able to remove and replace the organs of victims, use
              skills depending on the class and summon creatures. When you eat
              the heart of a sentient being, you regenerate your flesh.
            </Section>
            <Stack.Item>
              <ObjectivePrintout
                objectives={objectives}
                objectiveFollowup={
                  <ReplaceObjectivesButton
                    can_change_objective={can_change_objective}
                    button_title={'set yourself a goal'}
                    button_colour={'red'}
                  />
                }
              />
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
