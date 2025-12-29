import {
  AnimatedNumber,
  Box,
  Button,
  Flex,
  LabeledList,
  ProgressBar,
  Section,
  Slider,
} from 'tgui-core/components';
import { useBackend } from '../backend';
import { Window } from '../layouts';

interface TurbineData {
  connected: boolean;
  active: boolean;
  rpm: number;
  power: number;
  integrity: number;
  max_rpm: number;
  max_temperature: number;

  inlet_temp: number;
  rotor_temp: number;
  outlet_temp: number;

  compressor_pressure: number;
  rotor_pressure: number;
  outlet_pressure: number;

  regulator: number;
  steam_consumption: number;

  target_rpm: number; // Теперь это абсолютное значение RPM (не процент)
}

export const TrainTurbineComputer = () => {
  const { act, data } = useBackend<TurbineData>();
  const {
    connected,
    active,
    rpm,
    power,
    integrity,
    max_rpm,
    max_temperature,
    inlet_temp,
    rotor_temp,
    outlet_temp,
    compressor_pressure,
    rotor_pressure,
    outlet_pressure,
    regulator,
    steam_consumption,
    target_rpm,
  } = data;

  if (!connected) {
    return (
      <Window width={600} height={500}>
        <Window.Content>
          <Section title="Ошибка">
            <Box color="bad" fontSize="1.2rem">
              Турбина не обнаружена или не полностью собрана!
            </Box>
          </Section>
        </Window.Content>
      </Window>
    );
  }

  const tempWarning = rotor_temp > max_temperature * 0.9;
  const pressureWarning = rotor_pressure > 500;
  const integrityWarning = integrity < 30;

  const turbineColor =
    integrity < 30 ? 'bad' : integrity < 70 ? 'average' : 'good';

  return (
    <Window width={900} height={700} theme="retro">
      <Window.Content scrollable>
        <Flex direction="row" spacing={2} height="100%">
          {/* Левый столбец: Статус и управление */}
          <Flex.Item grow={1} basis={0} minWidth="280px">
            <Section title="Статус турбины" mb={2}>
              <LabeledList>
                <LabeledList.Item label="Состояние">
                  <Button
                    content={active ? 'ВКЛЮЧЕНА' : 'ВЫКЛЮЧЕНА'}
                    color={active ? 'good' : 'bad'}
                    icon={active ? 'power-off' : 'power-off'}
                    onClick={() => act('toggle_power')}
                    disabled={active && rpm > 1000}
                  />
                  {active && rpm > 1000 && (
                    <Box inline color="bad" ml={1} fontSize="0.9rem">
                      (RPM &gt; 1000)
                    </Box>
                  )}
                </LabeledList.Item>

                <LabeledList.Item label="Целостность корпуса">
                  <ProgressBar
                    value={integrity / 100}
                    color={
                      integrityWarning
                        ? 'bad'
                        : integrity < 70
                          ? 'average'
                          : 'good'
                    }
                  >
                    <AnimatedNumber
                      value={integrity}
                      format={(v) => Math.round(Number(v)).toString()}
                    />{' '}
                    %
                  </ProgressBar>
                </LabeledList.Item>

                <LabeledList.Item label="Мощность">
                  <Box fontSize="1.4rem" color="good">
                    <AnimatedNumber value={power} /> kW
                  </Box>
                </LabeledList.Item>
              </LabeledList>
            </Section>

            <Section title="Управление впуском">
              <LabeledList>
                <LabeledList.Item label="Регулятор пара">
                  <Slider
                    minValue={0.01}
                    maxValue={1}
                    step={0.01}
                    stepPixelSize={8}
                    value={regulator}
                    onChange={(_, value) =>
                      act('regulate', { regulate: value })
                    }
                    format={(v) => `${(v * 100).toFixed(0)}%`}
                  />
                </LabeledList.Item>

                <LabeledList.Item label="Потребление пара">
                  <Flex direction="row" align="center">
                    <Button
                      onClick={() =>
                        act('adjust_steam_rate', { adjust: -0.05 })
                      }
                    >
                      -
                    </Button>
                    <Box mx={2} width="80px" textAlign="center">
                      <AnimatedNumber
                        value={steam_consumption}
                        format={(v) => v.toFixed(2)}
                      />
                    </Box>
                    <Button
                      onClick={() => act('adjust_steam_rate', { adjust: 0.05 })}
                    >
                      +
                    </Button>
                  </Flex>
                  <Box fontSize="0.8rem" opacity={0.7}>
                    моль/тик → конденсация в воду
                  </Box>
                </LabeledList.Item>

                <LabeledList.Item label="Аварийный сброс">
                  <Button
                    content="СБРОС ГАЗА"
                    color="bad"
                    icon="exclamation-triangle"
                    onClick={() => act('emergency_vent')}
                    disabled={!active}
                    fluid
                  />
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Flex.Item>

          {/* Центральный столбец: Визуализация */}
          <Flex.Item grow={1.2} basis={0}>
            <Flex
              direction="column"
              align="center"
              justify="center"
              height="100%"
            >
              <Section
                title="Паровая турбина"
                backgroundColor={integrity < 30 ? '#330000' : undefined}
                p={3}
                textAlign="center"
              >
                <Box
                  fontFamily="monospace"
                  fontSize="1.6rem"
                  color={turbineColor}
                  lineHeight="1.2"
                  style={{
                    filter:
                      integrity < 50 ? 'drop-shadow(0 0 8px red)' : undefined,
                  }}
                >
                  {'          █████████          '}
                  <br />
                  {'        ██═════════██        '}
                  <br />
                  {'       ██═══╦═══╦═══██       '}
                  <br />
                  {'      ██═══╦═══╦═══██      '}
                  <br />
                  {'     ██═════════════██     '}
                  <br />
                  {'    ██═══ ROTOR ════██    '}
                  <br />
                  {'     ██═════════════██     '}
                  <br />
                  {'      ██═══╦═══╦═══██      '}
                  <br />
                  {'       ██═══╩═══╩═══██       '}
                  <br />
                  {'        ██═════════██        '}
                  <br />
                  {'          █████████          '}
                  <br />
                </Box>

                <Box mt={2} fontSize="1.8rem" bold color={turbineColor}>
                  <AnimatedNumber
                    value={rpm}
                    format={(v) => Math.round(v).toLocaleString()}
                  />{' '}
                  RPM
                </Box>

                <Box mt={1}>
                  <ProgressBar
                    value={rpm / max_rpm}
                    color={
                      rpm > max_rpm * 0.95
                        ? 'bad'
                        : rpm > max_rpm * 0.8
                          ? 'average'
                          : 'good'
                    }
                    width="240px"
                  >
                    {rpm > max_rpm ? 'ПЕРЕГРУЗКА!' : 'Норма'}
                  </ProgressBar>
                </Box>

                <Box mt={2} fontSize="1.1rem" opacity={0.8}>
                  Температура ротора: <AnimatedNumber value={rotor_temp} /> K
                </Box>
              </Section>
            </Flex>
          </Flex.Item>

          {/* Правый столбец: Датчики */}
          <Flex.Item grow={1} basis={0} minWidth="280px">
            <Section title="Температуры (K)" mb={2}>
              <LabeledList>
                <LabeledList.Item label="Вход">
                  <ProgressBar
                    value={(inlet_temp - 273) / (max_temperature - 273)}
                    color="teal"
                  >
                    <AnimatedNumber value={inlet_temp} /> K
                  </ProgressBar>
                </LabeledList.Item>
                <LabeledList.Item label="Ротор">
                  <ProgressBar
                    value={rotor_temp / max_temperature}
                    color={tempWarning ? 'bad' : 'good'}
                  >
                    <AnimatedNumber value={rotor_temp} /> / {max_temperature} K
                  </ProgressBar>
                </LabeledList.Item>
                <LabeledList.Item label="Выход">
                  <ProgressBar
                    value={(outlet_temp - 273) / (800 - 273)}
                    color="blue"
                  >
                    <AnimatedNumber value={outlet_temp} /> K
                  </ProgressBar>
                </LabeledList.Item>
              </LabeledList>
            </Section>

            <Section title="Давление (kPa)">
              <LabeledList>
                <LabeledList.Item label="Компрессор">
                  <ProgressBar value={compressor_pressure / 1000} color="good">
                    <AnimatedNumber value={compressor_pressure} /> kPa
                  </ProgressBar>
                </LabeledList.Item>
                <LabeledList.Item label="Ротор">
                  <ProgressBar
                    value={rotor_pressure / 800}
                    color={pressureWarning ? 'bad' : 'average'}
                  >
                    <AnimatedNumber value={rotor_pressure} /> kPa
                  </ProgressBar>
                </LabeledList.Item>
                <LabeledList.Item label="Выход">
                  <ProgressBar value={outlet_pressure / 300} color="blue">
                    <AnimatedNumber value={outlet_pressure} /> kPa
                  </ProgressBar>
                </LabeledList.Item>
              </LabeledList>
            </Section>

            <Section title="Желаемые обороты">
              <Slider
                minValue={0}
                maxValue={max_rpm}
                step={50}
                stepPixelSize={2}
                value={target_rpm}
                onChange={(_, value) =>
                  act('set_target_rpm', { target: value })
                }
                unit="RPM"
                height="24px"
                fontSize="1.1rem"
              />
              <Box textAlign="center" mt={1} opacity={0.8}>
                {((target_rpm / max_rpm) * 100).toFixed(1)}% от максимума
              </Box>
            </Section>
          </Flex.Item>
        </Flex>

        {/* Предупреждения */}
        {(tempWarning || pressureWarning || integrityWarning) && (
          <Section
            title="ВНИМАНИЕ!"
            backgroundColor="#550000"
            mt={2}
            textAlign="center"
          >
            {tempWarning && (
              <Box color="bad" bold>
                ПЕРЕГРЕВ РОТОРА!
              </Box>
            )}
            {pressureWarning && (
              <Box color="bad" bold>
                КРИТИЧЕСКОЕ ДАВЛЕНИЕ В РОТОРЕ!
              </Box>
            )}
            {integrityWarning && (
              <Box color="bad" bold>
                ПОВРЕЖДЕНИЕ КОРПУСА!
              </Box>
            )}
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
