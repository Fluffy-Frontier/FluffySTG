// THIS IS A NOVA SECTOR UI FILE
import { Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Objective } from './common/Objectives';

type Info = {
  antag_name: string;
  objectives: Objective[];
};

export const Rules = (props) => {
  const { data } = useBackend<Info>();
  const { antag_name } = data;
  switch (antag_name) {
    case 'Abductor Agent':
    case 'Abductor Scientist':
    case 'Abductor Solo':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://fluffy-frontier.ru/politika-antagonistov#абдуктор-серые-похитители">
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
              <a href="https://fluffy-frontier.ru/politika-antagonistov#контрактник">
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
              <a href="https://fluffy-frontier.ru/politika-antagonistov#кортикал-борер">
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
              <a href="https://fluffy-frontier.ru/politika-antagonistov#пожиратели-растения-из-лозы">
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
              <a href="https://fluffy-frontier.ru/politika-antagonistov#obsessed-одержимый-помешанный">
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
              <a href="https://fluffy-frontier.ru/politika-antagonistov#ревенант-фиолетовый-призрак">
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
              <a href="https://fluffy-frontier.ru/politika-antagonistov#космический-дракон">
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
              <a href="https://fluffy-frontier.ru/politika-antagonistov#пираты">
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
              <a href="https://fluffy-frontier.ru/politika-antagonistov#блоб">
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
              <a href="https://fluffy-frontier.ru/politika-antagonistov#генокрад">
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
          <Stack.Item>
            {
              <a href="https://wiki.novasector13.com/index.php/Antagonist_Policy#Clockcult_(OPFOR)">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'AssaultOps':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://fluffy-frontier.ru/politika-antagonistov#штурмовые-оперативники">
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
              <a href="https://fluffy-frontier.ru/politika-antagonistov#еретик">
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
              <a href="https://fluffy-frontier.ru/politika-antagonistov#малф-сбойный-ии">
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
              <a href="https://fluffy-frontier.ru/politika-antagonistov#морфлинг-морф">
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
              <a href="https://fluffy-frontier.ru/politika-antagonistov#nightmare-кошмар-тень">
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
              <a href="https://fluffy-frontier.ru/politika-antagonistov#ниндзя">
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
              <a href="https://fluffy-frontier.ru/politika-antagonistov#маг">
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
              <a href="https://fluffy-frontier.ru/politika-antagonistov#предатель-агент">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
      break;
  }
};
