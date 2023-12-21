// THIS IS A SKYRAT UI FILE
import { useBackend } from '../backend';
import { Stack } from '../components';
import { Objective } from './common/Objectives';

type Info = {
  antag_name: string;
  objectives: Objective[];
};

export const Rules = (props) => {
  const { data } = useBackend<Info>();
  const { antag_name } = data;
  switch (antag_name) {
    case 'Abductor Agent' || 'Abductor Scientist' || 'Abductor Solo':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
<<<<<<< HEAD
              <a href="https://fluffy-frontier.ru/politika-antagonistov#абдуктор-серые-похитители">
=======
              <a href="https://wiki.skyrat13.com/index.php/Antagonist_Policy#Abductors!_Station_Threat">
>>>>>>> dac72373 (Replaces old Wiki link(s) to new Wiki link(s) (#25757))
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
      break;
    case 'Drifting Contractor':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
<<<<<<< HEAD
              <a href="https://fluffy-frontier.ru/politika-antagonistov#контрактник">
=======
              <a href="https://wiki.skyrat13.com/index.php/Antagonist_Policy#Contractor!">
>>>>>>> dac72373 (Replaces old Wiki link(s) to new Wiki link(s) (#25757))
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
      break;
    case 'Cortical Borer':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
<<<<<<< HEAD
              <a href="https://fluffy-frontier.ru/politika-antagonistov#кортикал-борер">
=======
              <a href="https://wiki.skyrat13.com/index.php/Antagonist_Policy#Cortical_Borer!_PERMANENT_MECHANICAL_STATE">
>>>>>>> dac72373 (Replaces old Wiki link(s) to new Wiki link(s) (#25757))
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
      break;
    case 'Venus Human Trap':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
<<<<<<< HEAD
              <a href="https://fluffy-frontier.ru/politika-antagonistov#пожиратели-растения-из-лозы">
=======
              <a href="https://wiki.skyrat13.com/index.php/Antagonist_Policy#Man_Eaters!_PERMANENT_MECHANICAL_STATE">
>>>>>>> dac72373 (Replaces old Wiki link(s) to new Wiki link(s) (#25757))
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
      break;
    case 'Obsessed':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
<<<<<<< HEAD
              <a href="https://fluffy-frontier.ru/politika-antagonistov#obsessed-одержимый-помешанный">
=======
              <a href="https://wiki.skyrat13.com/index.php/Antagonist_Policy#Obsessed!">
>>>>>>> dac72373 (Replaces old Wiki link(s) to new Wiki link(s) (#25757))
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
      break;
    case 'Revenant':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
<<<<<<< HEAD
              <a href="https://fluffy-frontier.ru/politika-antagonistov#ревенант-фиолетовый-призрак">
=======
              <a href="https://wiki.skyrat13.com/index.php/Antagonist_Policy#Revenant!_PERMANENT_MECHANICAL_STATE">
>>>>>>> dac72373 (Replaces old Wiki link(s) to new Wiki link(s) (#25757))
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
      break;
    case 'Space Dragon':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
<<<<<<< HEAD
              <a href="https://fluffy-frontier.ru/politika-antagonistov#космический-дракон">
=======
              <a href="https://wiki.skyrat13.com/index.php/Antagonist_Policy#Space_Dragon!_PERMANENT_MECHANICAL_STATE">
>>>>>>> dac72373 (Replaces old Wiki link(s) to new Wiki link(s) (#25757))
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
      break;
    case 'Space Pirate':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
<<<<<<< HEAD
              <a href="https://fluffy-frontier.ru/politika-antagonistov#пираты">
=======
              <a href="https://wiki.skyrat13.com/index.php/Antagonist_Policy#Space_Pirates!_Station_Threat">
>>>>>>> dac72373 (Replaces old Wiki link(s) to new Wiki link(s) (#25757))
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
      break;
    case 'Blob':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
<<<<<<< HEAD
              <a href="https://fluffy-frontier.ru/politika-antagonistov#блоб">
=======
              <a href="https://wiki.skyrat13.com/index.php/Antagonist_Policy#Blob!_PERMANENT_MECHANICAL_STATE">
>>>>>>> dac72373 (Replaces old Wiki link(s) to new Wiki link(s) (#25757))
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
      break;
    case 'Changeling':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
<<<<<<< HEAD
              <a href="https://fluffy-frontier.ru/politika-antagonistov#генокрад">
=======
              <a href="https://wiki.skyrat13.com/index.php/Antagonist_Policy#Changeling!_Station_Threat">
>>>>>>> dac72373 (Replaces old Wiki link(s) to new Wiki link(s) (#25757))
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'ClockCult':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
<<<<<<< HEAD
          <Stack.Item>{<a>Dont be an asshole.</a>}</Stack.Item>
=======
          <Stack.Item>
            {
              <a href="https://wiki.skyrat13.com/index.php/Antagonist_Policy#Clockcult_(OPFOR)">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
>>>>>>> dac72373 (Replaces old Wiki link(s) to new Wiki link(s) (#25757))
        </Stack>
      );
    case 'AssaultOps':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
<<<<<<< HEAD
              <a href="https://fluffy-frontier.ru/politika-antagonistov#штурмовые-оперативники">
=======
              <a href="https://wiki.skyrat13.com/index.php/Antagonist_Policy#Assault_Ops!">
>>>>>>> dac72373 (Replaces old Wiki link(s) to new Wiki link(s) (#25757))
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Heretic':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
<<<<<<< HEAD
              <a href="https://fluffy-frontier.ru/politika-antagonistov#еретик">
=======
              <a href="https://wiki.skyrat13.com/index.php/Antagonist_Policy#Heretic!">
>>>>>>> dac72373 (Replaces old Wiki link(s) to new Wiki link(s) (#25757))
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Malf AI':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
<<<<<<< HEAD
              <a href="https://fluffy-frontier.ru/politika-antagonistov#малф-сбойный-ии">
=======
              <a href="https://wiki.skyrat13.com/index.php/Antagonist_Policy#Malf_AI!">
>>>>>>> dac72373 (Replaces old Wiki link(s) to new Wiki link(s) (#25757))
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Morph':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
<<<<<<< HEAD
              <a href="https://fluffy-frontier.ru/politika-antagonistov#морфлинг-морф">
=======
              <a href="https://wiki.skyrat13.com/index.php/Antagonist_Policy#Morphling!_Station_Threat">
>>>>>>> dac72373 (Replaces old Wiki link(s) to new Wiki link(s) (#25757))
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Nightmare':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
<<<<<<< HEAD
              <a href="https://fluffy-frontier.ru/politika-antagonistov#nightmare-кошмар-тень">
=======
              <a href="https://wiki.skyrat13.com/index.php/Antagonist_Policy#Nightmare!_Station_Threat">
>>>>>>> dac72373 (Replaces old Wiki link(s) to new Wiki link(s) (#25757))
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Ninja':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
<<<<<<< HEAD
              <a href="https://fluffy-frontier.ru/politika-antagonistov#ниндзя">
=======
              <a href="https://wiki.skyrat13.com/index.php/Antagonist_Policy#Space_Ninja">
>>>>>>> dac72373 (Replaces old Wiki link(s) to new Wiki link(s) (#25757))
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Wizard':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
<<<<<<< HEAD
              <a href="https://fluffy-frontier.ru/politika-antagonistov#маг">
=======
              <a href="https://wiki.skyrat13.com/index.php/Antagonist_Policy#Wizard!">
>>>>>>> dac72373 (Replaces old Wiki link(s) to new Wiki link(s) (#25757))
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    default:
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
<<<<<<< HEAD
              <a href="https://fluffy-frontier.ru/politika-antagonistov#предатель-агент">
=======
              <a href="https://wiki.skyrat13.com/index.php/Antagonist_Policy#Traitor!">
>>>>>>> dac72373 (Replaces old Wiki link(s) to new Wiki link(s) (#25757))
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
      break;
  }
};
