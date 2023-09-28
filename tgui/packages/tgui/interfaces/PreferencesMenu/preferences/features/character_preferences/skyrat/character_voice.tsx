import { FeatureChoiced, FeatureDropdownInput, FeatureNumberInput, FeatureNumeric } from '../../base';

export const character_voice: FeatureChoiced = {
  name: 'Character Voice',
  component: FeatureDropdownInput,
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
/*
export const bark_preview: FeatureToggle = {
  name: 'Character Voice Check',
  component: CheckboxInput,
};
*/
