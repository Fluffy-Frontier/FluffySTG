import { exhaustiveCheck } from 'common/exhaustive';
import { useState } from 'react';

import { useBackend } from '../../backend';
import { Button, Dropdown, Flex, Stack } from '../../components'; // NOVA EDIT CHANGE - ORIGINAL: import { Stack } from '../../components';
import { Window } from '../../layouts';
import { AntagsPage } from './AntagsPage';
import { PreferencesMenuData } from './data';
import { JobsPage } from './JobsPage';
// NOVA EDIT
import { LanguagesPage } from './LanguagesMenu';
import { LimbsPage } from './LimbsPage';
// NOVA EDIT END
import { MainPage } from './MainPage';
import { PageButton } from './PageButton';
import { QuirksPage } from './QuirksPage';
import { SpeciesPage } from './SpeciesPage';

enum Page {
  Antags,
  Main,
  Jobs,
  // NOVA EDIT
  Limbs,
  Languages,
  // NOVA EDIT END
  Species,
  Quirks,
}

const CharacterProfiles = (props: {
  activeSlot: number;
  onClick: (index: number) => void;
  onButtonClick: (e: Event) => void; // TFF ADDITION - Character Deletion
  profiles: (string | null)[];
}) => {
  const { profiles, activeSlot, onClick, onButtonClick } = props; // NOVA EDIT CHANGE // TFF EDIT - Character Deletion
  let charLength = Object.values(profiles).filter((val) => val).length; // TFF ADDITION - Character Deletion
  return (
    <Flex /* NOVA EDIT CHANGE START - Nova uses a dropdown instead of buttons */
      align="center"
      justify="center"
    >
      <Flex.Item width="25%">
        <Dropdown
          width="100%"
          selected={activeSlot as unknown as string}
          displayText={profiles[activeSlot]}
          options={profiles.map((profile, slot) => ({
            value: slot,
            displayText: profile ?? 'New Character',
          }))}
          onSelected={(slot) => {
            onClick(slot);
          }}
        />
      </Flex.Item>
      {/* TFF ADDITION - Character Deletion */}
      <Flex.Item>
        <Button
          color="danger"
          icon="trash"
          width="1.7777rem"
          height="1.7777rem"
          ml="25%"
          disabled={charLength < 2}
          tooltip={
            charLength < 2
              ? "You can't delete a character if you only have one."
              : 'Delete a character'
          }
          onClick={(e) => {
            onButtonClick(e);
          }}
        />
      </Flex.Item>
      {/* TFF ADDITION END - Character Deletion */}
    </Flex> /* NOVA EDIT CHANGE END */
  );
};

export const CharacterPreferenceWindow = (props) => {
  const { act, data } = useBackend<PreferencesMenuData>();

  const [currentPage, setCurrentPage] = useState(Page.Main);

  let pageContents;

  switch (currentPage) {
    case Page.Antags:
      pageContents = <AntagsPage />;
      break;
    case Page.Jobs:
      pageContents = <JobsPage />;
      break;
    // NOVA EDIT
    case Page.Limbs:
      pageContents = <LimbsPage />;
      break;
    case Page.Languages:
      pageContents = <LanguagesPage />;
      break;
    // NOVA EDIT END
    case Page.Main:
      pageContents = (
        <MainPage openSpecies={() => setCurrentPage(Page.Species)} />
      );

      break;
    case Page.Species:
      pageContents = (
        <SpeciesPage closeSpecies={() => setCurrentPage(Page.Main)} />
      );

      break;
    case Page.Quirks:
      pageContents = <QuirksPage />;
      break;
    default:
      exhaustiveCheck(currentPage);
  }

  return (
    <Window title="Character Preferences" width={920} height={770}>
      <Window.Content scrollable>
        <Stack vertical fill>
          <Stack.Item>
            <CharacterProfiles
              activeSlot={data.active_slot - 1}
              onClick={(slot) => {
                act('change_slot', {
                  slot: slot + 1,
                });
              }}
              onButtonClick={(e) => {
                let choicedSlot = data.active_slot - 1;
                let availableSlots = Object.keys(data.character_profiles)
                  .filter((slot) => data.character_profiles[slot] !== null)
                  .map((slot) => parseInt(slot, 10)); // get all busy slots as num

                availableSlots.splice(availableSlots.indexOf(choicedSlot), 1); // remove our slot(which we want to delete)
                if (availableSlots?.length < 2) return;
                let slotToJump = availableSlots.reduce((prev, curr) => {
                  return Math.abs(curr - choicedSlot) <
                    Math.abs(prev - choicedSlot)
                    ? curr
                    : prev;
                }); // get nearest slot

                act('remove_slot', {
                  slot: data.active_slot,
                  name: Object.values(data.character_profiles)[choicedSlot],
                  slotToJump: slotToJump + 1,
                });
              }}
              profiles={data.character_profiles}
            />
          </Stack.Item>

          {!data.content_unlocked && (
            <Stack.Item align="center">
              Buy BYOND premium for more slots!
            </Stack.Item>
          )}

          <Stack.Divider />

          <Stack.Item>
            <Stack fill>
              <Stack.Item grow>
                <PageButton
                  currentPage={currentPage}
                  page={Page.Main}
                  setPage={setCurrentPage}
                  otherActivePages={[Page.Species]}
                >
                  Character
                </PageButton>
              </Stack.Item>

              <Stack.Item grow>
                <PageButton
                  currentPage={currentPage}
                  page={Page.Jobs}
                  setPage={setCurrentPage}
                >
                  {/*
                    Fun fact: This isn't "Jobs" so that it intentionally
                    catches your eyes, because it's really important!
                  */}
                  Occupations
                </PageButton>
              </Stack.Item>
              {
                // NOVA EDIT
              }
              <Stack.Item grow>
                <PageButton
                  currentPage={currentPage}
                  page={Page.Limbs}
                  setPage={setCurrentPage}
                >
                  Augments+
                </PageButton>
              </Stack.Item>

              <Stack.Item grow>
                <PageButton
                  currentPage={currentPage}
                  page={Page.Languages}
                  setPage={setCurrentPage}
                >
                  Languages
                </PageButton>
              </Stack.Item>
              {
                // NOVA EDIT END
              }
              <Stack.Item grow>
                <PageButton
                  currentPage={currentPage}
                  page={Page.Antags}
                  setPage={setCurrentPage}
                >
                  Antagonists
                </PageButton>
              </Stack.Item>

              <Stack.Item grow>
                <PageButton
                  currentPage={currentPage}
                  page={Page.Quirks}
                  setPage={setCurrentPage}
                >
                  Quirks
                </PageButton>
              </Stack.Item>
            </Stack>
          </Stack.Item>

          <Stack.Divider />

          <Stack.Item>{pageContents}</Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
