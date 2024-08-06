// THIS IS A FLUFFY FRONTIER UI FILE
import { BooleanLike } from '../../common/react';
import { useBackend } from '../backend';
import { Box, Button, Icon, NoticeBox, Stack } from '../components';
import { NtosWindow } from '../layouts';
import { MedicalRecordTabs } from './MedicalRecords/RecordTabs';
import { MedicalRecordView } from './MedicalRecords/RecordView';

export const NtosRecordsMedical = (props) => {
  const { data } = useBackend<MedicalRecordData>();
  const { authenticated } = data;

  return (
    <NtosWindow title="Medical Records" width={800} height={600}>
      <NtosWindow.Content>
        <Stack fill>
          {!authenticated ? <UnauthorizedView /> : <AuthView />}
        </Stack>
      </NtosWindow.Content>
    </NtosWindow>
  );
};

const UnauthorizedView = (props) => {
  const { act } = useBackend<MedicalRecordData>();

  return (
    <Stack.Item grow>
      <Stack fill vertical>
        <Stack.Item grow />
        <Stack.Item align="center" grow={2}>
          <Icon color="teal" name="staff-snake" size={15} />
        </Stack.Item>
        <Stack.Item align="center" grow>
          <Box color="good" fontSize="18px" bold mt={5}>
            Nanotrasen HealthPRO
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

const AuthView = (props) => {
  const { act } = useBackend<MedicalRecordData>();

  return (
    <>
      <Stack.Item grow>
        <MedicalRecordTabs />
      </Stack.Item>
      <Stack.Item grow={2}>
        <Stack fill vertical>
          <Stack.Item grow>
            <MedicalRecordView />
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
        </Stack>
      </Stack.Item>
    </>
  );
};

export type MedicalRecordData = {
  assigned_view: string;
  authenticated: BooleanLike;
  station_z: BooleanLike;
  physical_statuses: string[];
  mental_statuses: string[];
  records: MedicalRecord[];
  min_age: number;
  max_age: number;
  max_chrono_age: number; // NOVA EDIT ADDITION - Chronological age
};

export type MedicalRecord = {
  age: number;
  chrono_age: number; // NOVA EDIT ADDITION - Chronological age
  blood_type: string;
  crew_ref: string;
  dna: string;
  gender: string;
  major_disabilities: string;
  minor_disabilities: string;
  physical_status: string;
  mental_status: string;
  name: string;
  notes: MedicalNote[];
  quirk_notes: string;
  rank: string;
  species: string;
  trim: string;
  // NOVA EDIT START - RP Records
  past_general_records: string;
  past_medical_records: string;
  // NOVA EDIT END
};

export type MedicalNote = {
  author: string;
  content: string;
  note_ref: string;
  time: string;
};
