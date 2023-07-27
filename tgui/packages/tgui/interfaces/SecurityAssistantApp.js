import { useLocalState } from '../backend';
import { Collapsible, Table, Tabs, Section } from '../components';
import { NtosWindow } from '../layouts';
import { MarkdownRenderer } from './MarkdownViewer';
import spaceLawData from '../../../../config/security/space_law.json';
import tenCodes from '../../../../config/security/tencodes.json';

export const SecurityAssistantApp = (props, context) => {
  const [pageIndex, setPageIndex] = useLocalState(context, 'pageIndex', 1);
  return (
    <NtosWindow width={500} height={480}>
      <NtosWindow.Content scrollable>
        <Tabs>
          <Tabs.Tab
            icon="shield"
            lineHeight="23px"
            selected={pageIndex === 1}
            onClick={() => setPageIndex(1)}>
            Космический Закон
          </Tabs.Tab>
          <Tabs.Tab
            icon="walkie-talkie"
            lineHeight="23px"
            selected={pageIndex === 2}
            onClick={() => setPageIndex(2)}>
            Радио сокращения
          </Tabs.Tab>
          <Tabs.Tab
            icon="circle-info"
            lineHeight="23px"
            selected={pageIndex === 3}
            onClick={() => setPageIndex(3)}>
            О приложении
          </Tabs.Tab>
        </Tabs>
        {pageIndex === 1 && <SpaceLawsTab />}
        {pageIndex === 2 && <TenCodesTab />}
        {pageIndex === 3 && <AboutTab />}
      </NtosWindow.Content>
    </NtosWindow>
  );
};

const SpaceLawsTab = () => {
  return (
    <>
      {Object.entries(spaceLawData).map(([category, items]) => (
        <Section key={category} title={category}>
          {items.map((item) => {
            const [code, details] = Object.entries(item)[0];
            return (
              <Collapsible key={code} title={code + ' - ' + details.name}>
                <MarkdownRenderer content={details.description} />
              </Collapsible>
            );
          })}
        </Section>
      ))}
    </>
  );
};

const TenCodesTab = () => {
  return (
    <>
      {Object.entries(tenCodes).map(([category, items]) => (
        <Section key={category} title={category}>
          <Table>
            <Table.Row header>
              <Table.Cell>Код</Table.Cell>
              <Table.Cell>Значение</Table.Cell>
            </Table.Row>
            {items.map((item) => {
              const [code, details] = Object.entries(item)[0];
              return (
                <Table.Row key={code}>
                  <Table.Cell>{code}</Table.Cell>
                  <Table.Cell>{details.description}</Table.Cell>
                </Table.Row>
              );
            })}
          </Table>
        </Section>
      ))}
    </>
  );
};

const AboutTab = () => {
  return (
    <>
      <Section title="О Приложении">
        <div>
          <h1 style={{ textAlign: 'center' }}>
            <strong>СБ для чайников&trade;</strong>
          </h1>
          <p style={{ textAlign: 'center' }}>Version: 1.0</p>
          <p style={{ textAlign: 'center' }}>NanoTrasen Corporation</p>
        </div>
      </Section>
      <Section title="Описание">
        {
          'Вы офицер, ваш IQ ниже среднего и вас с трудом удаётся запоминить "облегчённую" версию Космозакона? Не беда. С этим простым справочником вы всегда можете подсмотреть справочную информацию по вашему делу. С ним вы станете отличным офицером. Даже с половиной мозга.'
        }
      </Section>
    </>
  );
};
