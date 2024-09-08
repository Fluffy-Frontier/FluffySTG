// THIS IS A FLUFFY FRONTIER UI FILE
import { useState } from 'react';

import { filter, sortBy } from '../../common/collections';
import { BooleanLike } from '../../common/react';
import { useBackend, useLocalState } from '../backend';
import {
  Box,
  Button,
  Icon,
  Image,
  Input,
  NoticeBox,
  Section,
  Stack,
  Tabs,
} from '../components';
import { NtosWindow } from '../layouts';
import { JOB2ICON } from './common/JobToIcon';
import { NtPicture } from './NtosMessenger/types';
import { CRIMESTATUS2COLOR } from './SecurityRecords/constants';
import { isRecordMatch } from './SecurityRecords/helpers';
// import { SecurityRecordTabs } from './SecurityRecords/RecordTabs';
import { SecurityRecordView } from './SecurityRecords/RecordView';

export const NtosRecordsSecurity = (props) => {
  const { data } = useBackend<SecurityRecordsData>();
  const { authenticated } = data;

  return (
    <NtosWindow title="Security Records" width={800} height={600}>
      <NtosWindow.Content>
        <Stack fill>{!authenticated ? <RestrictedView /> : <AuthView />}</Stack>
      </NtosWindow.Content>
    </NtosWindow>
  );
};

/** Unauthorized view. User can only log in with ID */
const RestrictedView = (props) => {
  const { act } = useBackend<SecurityRecordsData>();

  return (
    <Stack.Item grow>
      <Stack fill vertical>
        <Stack.Item grow />
        <Stack.Item align="center" grow={2}>
          <Icon color="average" name="exclamation-triangle" size={15} />
        </Stack.Item>
        <Stack.Item align="center" grow>
          <Box color="red" fontSize="18px" bold mt={5}>
            Nanotrasen SecurityHUB
          </Box>
        </Stack.Item>
        <Stack.Item>
          <NoticeBox align="right">
            You are not logged in.
            <Button ml={2} icon="lock-open" onClick={() => act('login')}>
              Login
            </Button>
          </NoticeBox>
        </Stack.Item>
      </Stack>
    </Stack.Item>
  );
};

/** Logged in view */
const AuthView = (props) => {
  const { act, data } = useBackend<SecurityRecordsData>();
  const { selecting_photo, storedPhotos } = data;

  const photos = storedPhotos!.map((photo) => (
    <Stack.Item key={photo.uid}>
      <Button
        pt={1}
        onClick={() => {
          act('add_record', { uid: photo.uid });
        }}
      >
        <Image src={photo.path} maxHeight={10} />
      </Button>
    </Stack.Item>
  ));

  return (
    <>
      <Stack.Item grow>
        <SecurityRecordTabs />
      </Stack.Item>
      <Stack.Item grow={2}>
        <Stack fill vertical>
          <Stack.Item grow>
            <SecurityRecordView />
          </Stack.Item>
          <Stack.Item>
            <NoticeBox align="right" info>
              Secure Your Workspace.
              <Button
                align="right"
                icon="lock"
                color="good"
                ml={2}
                onClick={() => act('logout')}
              >
                Log Out
              </Button>
            </NoticeBox>
          </Stack.Item>
          {!!selecting_photo && (
            <Stack.Item>
              <Section fill>
                {photos.length > 0 ? (
                  <Section scrollableHorizontal>
                    <Stack fill>{photos}</Stack>
                  </Section>
                ) : (
                  <Box as="span" ml={1}>
                    No photos 1x1 size found
                  </Box>
                )}
              </Section>
            </Stack.Item>
          )}
        </Stack>
      </Stack.Item>
    </>
  );
};

/** Tabs on left, with search bar */
export const SecurityRecordTabs = (props) => {
  const { act, data } = useBackend<SecurityRecordsData>();
  const { selecting_photo, higher_access, records = [] } = data;

  const errorMessage = !records.length
    ? 'No records found.'
    : 'No match. Refine your search.';

  const [search, setSearch] = useState('');

  const sorted = sortBy(
    filter(records, (record) => isRecordMatch(record, search)),
    (record) => record.name,
  );

  return (
    <Stack fill vertical>
      <Stack.Item>
        <Input
          fluid
          placeholder="Name/Job/Fingerprints"
          onInput={(event, value) => setSearch(value)}
        />
      </Stack.Item>
      <Stack.Item grow>
        <Section fill scrollable>
          <Tabs vertical>
            {!sorted.length ? (
              <NoticeBox>{errorMessage}</NoticeBox>
            ) : (
              sorted.map((record, index) => (
                <CrewTab record={record} key={index} />
              ))
            )}
          </Tabs>
        </Section>
      </Stack.Item>
      <Stack.Item align="center">
        <Stack fill>
          <Stack.Item>
            <Button
              // disabled={!higher_access}
              icon={selecting_photo ? 'arrow-left' : 'plus'}
              tooltip="Scan photo by showing it to PC. Them you will be able select it here."
              onClick={() => act('photo_selector')}
            >
              {selecting_photo ? 'Cancel' : 'Create'}
            </Button>
          </Stack.Item>
          <Stack.Item>
            <Button.Confirm
              content="Purge"
              disabled={!higher_access}
              icon="trash"
              onClick={() => act('purge_records')}
              tooltip="Wipe criminal record data."
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

/** Individual record */
const CrewTab = (props: { record: SecurityRecord }) => {
  const [selectedRecord, setSelectedRecord] = useLocalState<
    SecurityRecord | undefined
  >('securityRecord', undefined);

  const { act, data } = useBackend<SecurityRecordsData>();
  const { assigned_view } = data;
  const { record } = props;
  const { crew_ref, name, trim, wanted_status } = record;

  /** Chooses a record */
  const selectRecord = (record: SecurityRecord) => {
    if (selectedRecord?.crew_ref === crew_ref) {
      setSelectedRecord(undefined);
    } else {
      setSelectedRecord(record);
      act('view_record', { assigned_view: assigned_view, crew_ref: crew_ref });
    }
  };

  const isSelected = selectedRecord?.crew_ref === crew_ref;

  return (
    <Tabs.Tab
      className="candystripe"
      onClick={() => selectRecord(record)}
      selected={isSelected}
    >
      <Box bold={isSelected} color={CRIMESTATUS2COLOR[wanted_status]}>
        <Icon name={JOB2ICON[trim] || 'question'} /> {name}
      </Box>
    </Tabs.Tab>
  );
};

export type SecurityRecordsData = {
  assigned_view: string;
  authenticated: BooleanLike;
  available_statuses: string[];
  current_user: string;
  higher_access: BooleanLike;
  records: SecurityRecord[];
  min_age: number;
  max_age: number;
  max_chrono_age: number; // NOVA EDIT ADDITION - Chronological age
  selecting_photo: BooleanLike;
  storedPhotos?: NtPicture[];
};

export type SecurityRecord = {
  age: number;
  chrono_age: number; // NOVA EDIT ADDITION - Chronological age
  citations: Crime[];
  crew_ref: string;
  crimes: Crime[];
  fingerprint: string;
  gender: string;
  name: string;
  note: string;
  rank: string;
  species: string;
  trim: string;
  wanted_status: string;
  voice: string;
  // NOVA EDIT START - RP Records
  past_general_records: string;
  past_security_records: string;
  // NOVA EDIT END
};

export type Crime = {
  author: string;
  crime_ref: string;
  details: string;
  fine: number;
  name: string;
  paid: number;
  time: number;
  valid: BooleanLike;
};

export enum SECURETAB {
  Crimes,
  Citations,
  Add,
}

export enum PRINTOUT {
  Missing = 'missing',
  Rapsheet = 'rapsheet',
  Wanted = 'wanted',
}
