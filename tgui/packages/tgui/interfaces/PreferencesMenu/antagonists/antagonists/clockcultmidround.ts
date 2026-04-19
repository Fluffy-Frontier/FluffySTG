import { type Antagonist, Category } from '../base';

export const MIDROUND_CLOCKWORK_MECHANICAL_DESCRIPTION = `
You have discovered the secret knowledge and enlightenment at the station.
Perhaps Ratvar himself chose you as his follower, but it doesn't matter.
Now you must restore him to the world of the living...
`;

const MidroundClockworkCultist: Antagonist = {
  key: 'midroundclockworkcultist',
  name: 'Midround Clockwork Cultist',
  description: [
    MIDROUND_CLOCKWORK_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Midround,
};

export default MidroundClockworkCultist;
