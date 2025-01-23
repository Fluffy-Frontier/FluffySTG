// Если сломается - смотрите как реализован интерфейс CommunicationsConsole.jsx
import { useState } from 'react';
import {
  Blink,
  Box,
  Button,
  Dimmer,
  Flex,
  Icon,
  Modal,
  Section,
  TextArea,
} from 'tgui-core/components';

import { useBackend, useLocalState } from '../backend';
import { Window } from '../layouts';
import { sanitizeText } from '../sanitize';

const STATE_MAIN = 'main';
const STATE_MESSAGES = 'messages';

const MessageModal = (props) => {
  const { data } = useBackend();
  const { maxMessageLength } = data;

  const [input, setInput] = useLocalState(props.label, '');

  const longEnough =
    props.minLength === undefined || input.length >= props.minLength;

  return (
    <Modal>
      <Flex direction="column">
        <Flex.Item fontSize="16px" maxWidth="90vw" mb={1}>
          {props.label}:
        </Flex.Item>

        <Flex.Item mr={2} mb={1}>
          <TextArea
            fluid
            height="20vh"
            width="80vw"
            backgroundColor="black"
            textColor="white"
            onInput={(_, value) => {
              setInput(value.substring(0, maxMessageLength));
            }}
            value={input}
          />
        </Flex.Item>

        <Flex.Item>
          <Button
            icon={props.icon}
            content={props.buttonText}
            color="good"
            disabled={!longEnough}
            tooltip={!longEnough ? 'You need a longer reason.' : ''}
            tooltipPosition="right"
            onClick={() => {
              if (longEnough) {
                setInput('');
                props.onSubmit(input);
              }
            }}
          />

          <Button
            icon="times"
            content="Cancel"
            color="bad"
            onClick={props.onBack}
          />
        </Flex.Item>

        {!!props.notice && (
          <Flex.Item maxWidth="90vw">{props.notice}</Flex.Item>
        )}
      </Flex>
    </Modal>
  );
};

const NoConnectionModal = () => {
  return (
    <Dimmer>
      <Flex direction="column" textAlign="center" width="300px">
        <Flex.Item>
          <Icon color="red" name="wifi" size={10} />

          <Blink>
            <div
              style={{
                background: '#db2828',
                bottom: '60%',
                left: '25%',
                height: '10px',
                position: 'relative',
                transform: 'rotate(45deg)',
                width: '150px',
              }}
            />
          </Blink>
        </Flex.Item>

        <Flex.Item fontSize="16px">
          A connection to the station cannot be established.
        </Flex.Item>
      </Flex>
    </Dimmer>
  );
};

const PageMain = (props) => {
  const { act, data } = useBackend();
  const { canMessageAssociates, importantActionReady, callPoliceReady } = data;
  const [messagingAssociates, setMessagingAssociates] = useState(false);

  return (
    <Box>
      <Section title="Functions">
        <Flex direction="column">
          <Button
            icon="envelope-o"
            content="Message List"
            onClick={() => act('setState', { state: STATE_MESSAGES })}
          />

          {
            <Button
              icon="comment-o"
              content={`Send message to CentCom`}
              disabled={!importantActionReady}
              onClick={() => setMessagingAssociates(true)}
            />
          }

          {
            <Button
              icon="bullhorn"
              content="Call NT Internal Security"
              disabled={!callPoliceReady}
              onClick={() => act('callThePolice')}
            />
          }
        </Flex>
      </Section>

      {!!canMessageAssociates && messagingAssociates && (
        <MessageModal
          label={`Message to transmit to CentCom via quantum entanglement`}
          notice="Please be aware that this process is very expensive, and abuse will lead to...termination. Transmission does not guarantee a response."
          icon="bullhorn"
          buttonText="Send"
          onBack={() => setMessagingAssociates(false)}
          onSubmit={(message) => {
            setMessagingAssociates(false);
            act('messageAssociates', {
              message,
            });
          }}
        />
      )}
    </Box>
  );
};

const PageMessages = (props) => {
  const { act, data } = useBackend();
  const messages = data.messages || [];

  const children = [];

  children.push(
    <Section>
      <Button
        icon="chevron-left"
        content="Back"
        onClick={() => act('setState', { state: STATE_MAIN })}
      />
    </Section>,
  );

  const messageElements = [];

  for (const [messageIndex, message] of Object.entries(messages)) {
    let answers = null;
    const textHtml = {
      __html: sanitizeText(message.content),
    };

    messageElements.push(
      <Section
        title={message.title}
        key={messageIndex}
        buttons={
          <Button.Confirm
            icon="trash"
            content="Delete"
            color="red"
            onClick={() =>
              act('deleteMessage', {
                message: messageIndex + 1,
              })
            }
          />
        }
      >
        <Box dangerouslySetInnerHTML={textHtml} />

        {answers}
      </Section>,
    );
  }

  children.push(messageElements.reverse());

  return children;
};

export const comNTR = (props) => {
  const { act, data } = useBackend();
  const { authenticated, authorizeName, canLogOut, hasConnection, page } = data;

  return (
    <Window width={400} height={650} theme={undefined}>
      <Window.Content scrollable>
        {!hasConnection && <NoConnectionModal />}

        {(canLogOut || !authenticated) && (
          <Section title="Authentication">
            <Button
              icon={authenticated ? 'sign-out-alt' : 'sign-in-alt'}
              content={
                authenticated
                  ? `Log Out${authorizeName ? ` (${authorizeName})` : ''}`
                  : 'Log In'
              }
              color={authenticated ? 'bad' : 'good'}
              onClick={() => act('toggleAuthentication')}
            />
          </Section>
        )}

        {!!authenticated &&
          ((page === STATE_MAIN && <PageMain />) ||
            (page === STATE_MESSAGES && <PageMessages />) || (
              <Box>Page not implemented: {page}</Box>
            ))}
      </Window.Content>
    </Window>
  );
};
