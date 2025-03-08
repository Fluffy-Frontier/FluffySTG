import { Icon, Section, Stack } from 'tgui-core/components';
import { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import {
  Objective,
  ObjectivePrintout,
  ReplaceObjectivesButton,
} from './common/Objectives';

const ninja_emphasis = {
  color: 'red',
};

type NecromorphInfo = {
  objectives: Objective[];
};

export const AntagInfoNecromorph = (props) => {
  const { data } = useBackend<NecromorphInfo>();
  const { objectives } = data;
  return (
    <Window width={550} height={450}>
      <Window.Content>
        <Section scrollable fill>
          <Stack vertical textColor="red">
            <Stack.Item textAlign="center" fontSize="20px">
              YOU ARE A <span style={ninja_emphasis}>NECROMORPH</span>!
            </Stack.Item>
            <Stack.Item textAlign="center" italic>
              Make them whole. Bring them to us.
            </Stack.Item>
            <Stack.Item>Check TFF Discord Guides for RULES.</Stack.Item>
            <Stack.Item>
              <ObjectivePrintout objectives={objectives} />
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
