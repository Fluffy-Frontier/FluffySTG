import { Icon, Section, Stack } from 'tgui-core/components';
import { useBackend } from '../backend';
import { Window } from '../layouts';
import { type Objective, ObjectivePrintout } from './common/Objectives';

type Info = {
  antag_name: string;
  objectives: Objective[];
  marked_areas: string[];
};

export const AntagInfoClockAlt = (props) => {
  const { data } = useBackend<Info>();
  const { antag_name, objectives, marked_areas } = data;
  return (
    <Window width={620} height={250} theme="clockwork">
      <Window.Content>
        <Section scrollable fill>
          <Stack vertical>
            <Stack.Item fontSize="20px" color={'good'}>
              <Icon name={'cog'} rotation={0} spin />
              {' You are the ' + antag_name + '! '}
              <Icon name={'cog'} rotation={35} spin />
            </Stack.Item>
            <Stack.Item>
              <ObjectivePrintout
                titleMessage={"To serve Rat'var you must"}
                objectives={objectives}
              />
            </Stack.Item>
            <Stack.Item>{'Our marked areas are: ' + marked_areas}</Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
