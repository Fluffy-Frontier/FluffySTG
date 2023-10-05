import { Button, Stack } from '../../../../../../components';
import { CheckboxInput, FeatureChoiced, FeatureChoicedServerData, FeatureDropdownInput, FeatureNumberInput, FeatureNumeric, FeatureToggle, FeatureValueProps } from '../../base';

const FeatureBarkDropdownInput = (
  props: FeatureValueProps<string, string, FeatureChoicedServerData>
) => {
  return (
    <Stack>
      <Stack.Item grow>
        <FeatureDropdownInput {...props} />
      </Stack.Item>
      <Stack.Item>
        <Button
          onClick={() => {
            props.act('play_bark');
          }}
          icon="play"
          width="100%"
          height="100%"
        />
      </Stack.Item>
    </Stack>
  );
};

export const bark_speech: FeatureChoiced = {
  name: 'Character Voice',
  component: FeatureBarkDropdownInput,
};

export const bark_speech_speed: FeatureNumeric = {
  name: 'Character Voice Speed',
  component: FeatureNumberInput,
};

export const bark_speech_pitch: FeatureNumeric = {
  name: 'Character Voice Pitch',
  component: FeatureNumberInput,
};

export const bark_pitch_range: FeatureNumeric = {
  name: 'Character Voice Range',
  component: FeatureNumberInput,
};

export const hear_sound_bark: FeatureToggle = {
  name: "Enable hearing player's barks",
  category: 'SOUND',
  component: CheckboxInput,
};

export const send_sound_bark: FeatureToggle = {
  name: 'Enable send to players barks',
  category: 'SOUND',
  component: CheckboxInput,
};
