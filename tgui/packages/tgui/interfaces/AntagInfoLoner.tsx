// THIS IS A FLUFFY FRONTIER FILE!
import { BlockQuote, LabeledList, Section, Stack } from 'tgui-core/components';

import { Window } from '../layouts';

const tipstyle = {
  color: 'lightblue',
};

const noticestyle = {
  color: 'goodstyle',
};

export const AntagInfoLoner = (props) => {
  return (
    <Window width={620} height={380}>
      <Window.Content backgroundColor="#0d0d0d">
        <Stack fill>
          <Stack.Item width="46.2%">
            <Section fill>
              <Stack vertical fill>
                <Stack.Item fontSize="25px">You are a Loner.</Stack.Item>
                <Stack.Item>
                  <BlockQuote>
                    You Are a Psi Agent, Loner. You possess high-power psionic
                    abilities that can strongly influence the space around you.
                    You were trained by the syndicate as part of an experiment
                    and must show the best results in completing the tasks
                    assigned to you. Gloty to the syndicate!
                  </BlockQuote>
                </Stack.Item>
                <Stack.Divider />
                <Stack.Item textColor="label">
                  <span style={tipstyle}>Tip #1:&ensp;</span>
                  You have quite a few defensive and healing spells, be careful
                  and fight cleverly!
                  <br />
                  <span style={tipstyle}>Tip #2:&ensp;</span>
                  Try to be secretive, you have many abilities that allow you to
                  easily and quietly enter any room!
                  <br />
                  <span style={tipstyle}>Tip #3:&ensp;</span>
                  Your abilities allow you to be a good support for syndicate
                  agent, cooperation is also the key to success!
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
          <Stack.Item width="53%">
            <Section fill title="Psi">
              <LabeledList>
                <LabeledList.Item label="Psi Energy">
                  Your abilities are wasting psionic energy, if your psionic
                  energy drops to 0, you will face unpleasant consequences!
                </LabeledList.Item>
                <LabeledList.Item label="Psi Signal">
                  All psionics are able to see each other's signals, but you can
                  suppress your signal and hide from other psionics.
                </LabeledList.Item>
                <LabeledList.Item label="Psi Implants">
                  There's a box of psionic implants in the cargo. This box
                  contains an implant that accelerates the production of psi
                  energy, as well as an implant that completely suppresses your
                  psionics.
                </LabeledList.Item>
                <LabeledList.Item label="Psi Shop">
                  You have a psionic store. Buy psionic abilities wisely! You
                  cannot change the abilities you have acquired.
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
