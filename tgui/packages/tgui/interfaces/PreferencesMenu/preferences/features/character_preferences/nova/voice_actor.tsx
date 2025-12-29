// THIS IS A NOVA SECTOR UI FILE
import {
  Feature,
  FeatureChoiced,
  FeatureColorInput,
  FeatureSliderInput,
  type FeatureValueProps
  FeatureNumberInput,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const voice_actor: FeatureChoiced = {
  name: 'Second Voice',
  component: FeatureDropdownInput,
};

export const voice_actor_pitch: Feature<number> = {
  name: 'Second Pitch',
  component: FeatureNumberInput,
};

export const voice_actor_color: Feature<string> = {
  name: 'Second Chat Color',
  component: FeatureColorInput,
};
