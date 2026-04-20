import { type Antagonist, Category } from '../base';

export const CLOCKWORK_MECHANICAL_DESCRIPTION = `
You were sent to the station to change the minds of the lost and revive
the Rat'Var. Will you be able to do it, or will you fall like your god?
`;

const RoundstartClockworkCultist: Antagonist = {
  key: 'roundstartclockworkcultist',
  name: 'Clockwork Cultist',
  description: [CLOCKWORK_MECHANICAL_DESCRIPTION],
  category: Category.Roundstart,
};

export default RoundstartClockworkCultist;
