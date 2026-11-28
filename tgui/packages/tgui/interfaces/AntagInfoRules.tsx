// THIS IS A NOVA SECTOR UI FILE
import { Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import type { Objective } from './common/Objectives';

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
              <a href="https://wiki.fluffy-frontier.ru/Заводной_культ(OPFOR)">
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
    case 'Xenomorph':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://fluffy-frontier.ru/politika-antagonistov#ксеноморфы">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'TGMC Xeno':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://fluffy-frontier.ru/politika-antagonistov#ксеноморфы">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
          <Stack.Item bold>Несколько важных моментов</Stack.Item>
          <Stack.Item>
            <ul>
              <li>
                По умолчанию скорость регенариции ХП и Плазмы очень маленькая,
                даже на вашей резине. Чтобы лечиться быстрее - используйте Rest
                в вербах или в правой нижней части экрана.
              </li>
              <li>Всего в игре 3 тира ксенов:</li>
              <ol>
                <li>Дрон, Руня, Дефендер и Сентинел</li>
                <li>Претор, Равагер, Крашер и Спиттер</li>
                <li>Королева</li>
              </ol>
              <li>
                Каждый из ксенов 2 и 3 тира может быть только в 1 экземпляре (То
                есть может быть 1 Претор и 1 Рава, но не могут быть 2 Преторов)
              </li>
              <li>
                Если к яйцам королевы в радиус 3 тайлов подойдет подходящий для
                заражения хост - оно автоматически выпустил хаггера в него. Вы
                можете использовать это как ловушки!
              </li>
            </ul>
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
  }
};
