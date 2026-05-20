import { useState } from 'react';
import {
  Box,
  Button,
  DmIcon,
  Icon,
  Input,
  NoticeBox,
  Section,
  Stack,
  Tabs,
  Tooltip,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

// ==========
// Types
// ==========
type SpellTypePath = string;

type Spell = {
  name: string;
  desc: string;
  helptext: string;
  path: SpellTypePath;
  point_required: number;
  category: string;
};

type PsionicShopContext = {
  many_spells: Spell[];
  psi_points_count: number;
  researched_spells: SpellTypePath[];
};

const nameToIconState = (name: string): string => {
  return name.toLowerCase().replace(/\s+/g, '_');
};

export const PsionicShop = (props) => {
  const { act, data } = useBackend<PsionicShopContext>();
  const { many_spells, psi_points_count, researched_spells } = data;

  const [searchText, setSearchText] = useState('');
  const [compactMode, setCompactMode] = useState(false);

  const CATEGORY_ORDER = ['utility', 'combat', 'manipulation'];
  const allCategories = Array.from(new Set(many_spells.map((a) => a.category)));
  const sortedCategories = [
    ...CATEGORY_ORDER.filter((cat) => allCategories.includes(cat)),
    ...allCategories.filter((cat) => !CATEGORY_ORDER.includes(cat)),
  ];
  const [selectedCategory, setSelectedCategory] = useState(
    sortedCategories[0] || 'combat',
  );

  const filteredItems = (
    searchText
      ? many_spells.filter((item) =>
          [item.name, item.desc, item.helptext]
            .join(' ')
            .toLowerCase()
            .includes(searchText.toLowerCase()),
        )
      : many_spells.filter((item) => item.category === selectedCategory)
  ).sort((a, b) => a.name.localeCompare(b.name));

  const handleBuy = (spell: Spell) => {
    act('research', { path: spell.path });
  };

  return (
    <Window width={900} height={520}>
      <Window.Content
        scrollable={false}
        style={{
          backgroundImage: "url('tgui-core/assets/bg-nanotrasen.svg')",
          backgroundSize: 'cover',
          backgroundRepeat: 'no-repeat',
          backgroundColor: '#1A1A1A',
          overflowY: 'auto',
        }}
      >
        <Section
          fill
          scrollable={false}
          title={
            <Stack fill>
              <Stack.Item fontSize="16px" color="#449bbd" ml={1}>
                <Icon name="dna" /> {psi_points_count} Psi
              </Stack.Item>
              <Stack.Item grow />
            </Stack>
          }
        >
          <Stack fill>
            <Stack.Item width="180px">
              <Stack vertical fill>
                <Stack.Item>
                  <Input
                    autoFocus
                    value={searchText}
                    placeholder="Search..."
                    onChange={setSearchText}
                    fluid
                  />
                </Stack.Item>
                <Stack.Item>
                  <Button
                    fluid
                    lineHeight={2}
                    textAlign="center"
                    icon={compactMode ? 'maximize' : 'minimize'}
                    tooltip={compactMode ? 'Detailed view' : 'Compact view'}
                    onClick={() => setCompactMode(!compactMode)}
                  />
                </Stack.Item>
                <Stack.Item grow>
                  <Tabs vertical fill>
                    {sortedCategories.map((category) => (
                      <Tabs.Tab
                        key={category}
                        selected={category === selectedCategory}
                        onClick={() => {
                          setSelectedCategory(category);
                          if (searchText) setSearchText('');
                        }}
                        mt={1}
                      >
                        {category.charAt(0).toUpperCase() + category.slice(1)}
                      </Tabs.Tab>
                    ))}
                  </Tabs>
                </Stack.Item>
              </Stack>
            </Stack.Item>

            <Stack.Item grow>
              <Box height="100%" pr={1} mr={-1}>
                {filteredItems.length === 0 ? (
                  <NoticeBox>
                    {searchText
                      ? 'No many_spells found.'
                      : 'No many_spells in this category.'}
                  </NoticeBox>
                ) : (
                  <ItemList
                    compactMode={searchText.length > 0 || compactMode}
                    items={filteredItems}
                    researched_spells={researched_spells}
                    psi_points_count={psi_points_count}
                    handleBuy={handleBuy}
                  />
                )}
              </Box>
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};

// ==========
// ItemList Component
// ==========
type SpellListProps = {
  compactMode: BooleanLike;
  items: Spell[];
  researched_spells: SpellTypePath[];
  psi_points_count: number;
  handleBuy: (item: Spell) => void;
};

const ItemList = (props: SpellListProps) => {
  const { compactMode, items, researched_spells, psi_points_count, handleBuy } =
    props;

  const iconSize = compactMode ? '32px' : '64px';

  return (
    <Section fill scrollable>
      <Stack vertical mt={compactMode ? 0.5 : 0}>
        {items.map((spell) => {
          const owned = researched_spells.includes(spell.path);
          const canAfford = !owned && spell.point_required <= psi_points_count;

          const requirementTooltip = [`${spell.point_required} Psi`].join(', ');

          const costDisplay = `Cost: ${spell.point_required} Psi`;

          const iconState = nameToIconState(spell.name);

          return (
            <Stack.Item key={spell.path} mt={compactMode ? 0.5 : 1}>
              <Section fitted={!!compactMode}>
                <Stack>
                  <Stack.Item>
                    <Box ml={2}>
                      <Box
                        width={iconSize}
                        height={iconSize}
                        position="relative"
                        m={compactMode ? '2px' : 0}
                        mr={1}
                      >
                        <DmIcon
                          position="absolute"
                          top="0"
                          left="0"
                          icon="icons/mob/actions/backgrounds.dmi"
                          icon_state="bg_tech_blue"
                          width={iconSize}
                          fallback={null}
                        />
                        <DmIcon
                          position="absolute"
                          top="0"
                          left="0"
                          icon="tff_modular/modules/psionics/icons/spells.dmi"
                          icon_state={iconState}
                          width={iconSize}
                          fallback={<Icon name="question-circle" size={3} />}
                        />
                      </Box>
                    </Box>
                  </Stack.Item>
                  <Stack.Item grow>
                    {compactMode ? (
                      <Stack>
                        <Stack.Item
                          bold
                          grow
                          lineHeight="36px"
                          style={{
                            overflow: 'hidden',
                            whiteSpace: 'nowrap',
                            textOverflow: 'ellipsis',
                            opacity: owned ? '0.5' : '1',
                          }}
                        >
                          {owned ? (
                            <Box color="#449bbd">
                              <Icon mr="8px" name="check" />
                              {spell.name}
                            </Box>
                          ) : (
                            spell.name
                          )}
                        </Stack.Item>
                        <Stack.Item>
                          <Tooltip content={spell.helptext || spell.desc}>
                            <Icon name="info-circle" lineHeight="36px" />
                          </Tooltip>
                        </Stack.Item>
                        <Stack.Item>
                          <Tooltip content={requirementTooltip}>
                            <Button
                              m="8px"
                              color={canAfford ? 'average' : 'bad'}
                              disabled={owned || !canAfford}
                              onClick={() => handleBuy(spell)}
                            >
                              {costDisplay}
                            </Button>
                          </Tooltip>
                        </Stack.Item>
                      </Stack>
                    ) : (
                      <Section
                        title={
                          <Box>
                            {spell.name}
                            {owned && (
                              <Box color="#449bbd" inline ml={1}>
                                (Owned)
                              </Box>
                            )}
                          </Box>
                        }
                        buttons={
                          <Tooltip content={requirementTooltip}>
                            <Box mt={-3}>
                              <Button
                                disabled={owned || !canAfford}
                                color={
                                  owned ? 'good' : canAfford ? 'average' : 'bad'
                                }
                                onClick={() => handleBuy(spell)}
                              >
                                {costDisplay}
                              </Button>
                            </Box>
                          </Tooltip>
                        }
                      >
                        <Box opacity={0.8}>{spell.desc}</Box>
                        {spell.helptext && (
                          <Box color="#449bbd" mt={0.5}>
                            {spell.helptext}
                          </Box>
                        )}
                      </Section>
                    )}
                  </Stack.Item>
                </Stack>
              </Section>
            </Stack.Item>
          );
        })}
      </Stack>
    </Section>
  );
};
