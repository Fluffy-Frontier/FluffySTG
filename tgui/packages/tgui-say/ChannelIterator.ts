export type Channel =
  | 'Say'
  | 'Radio'
  | 'Me'
  // NOVA EDIT ADDITION START
  | 'Whis'
  | 'LOOC'
  | 'Do'
  // NOVA EDIT ADDITION END
  | 'OOC'
  | 'Admin'
  | 'Event'; // TFF EDIT - Eventmaker

/**
 * ### ChannelIterator
 * Cycles a predefined list of channels,
 * skipping over blacklisted ones,
 * and providing methods to manage and query the current channel.
 */
export class ChannelIterator {
  private index: number = 0;
  private readonly channels: Channel[] = [
    'Say',
    'Radio',
    'Me',
    // NOVA EDIT ADDITION
    'Whis',
    'LOOC',
    'Do',
    // NOVA EDIT ADDITION
    'OOC',
    'Admin',
    'Event', // TFF EDIT - Eventmaker
  ];
  private readonly blacklist: Channel[] = ['Admin', 'Event']; // TFF EDIT - Eventmaker
  private readonly quiet: Channel[] = ['OOC', 'LOOC', 'Admin', 'Event']; // NOVA EDIT CHANGE (Add LOOC) // TFF EDIT - Eventmaker

  public next(): Channel {
    if (this.blacklist.includes(this.channels[this.index])) {
      return this.channels[this.index];
    }

    for (let index = 1; index <= this.channels.length; index++) {
      let nextIndex = (this.index + index) % this.channels.length;
      if (!this.blacklist.includes(this.channels[nextIndex])) {
        this.index = nextIndex;
        break;
      }
    }

    return this.channels[this.index];
  }

  public set(channel: Channel): void {
    this.index = this.channels.indexOf(channel) || 0;
  }

  public current(): Channel {
    return this.channels[this.index];
  }

  public isSay(): boolean {
    return this.channels[this.index] === 'Say';
  }

  public isVisible(): boolean {
    return !this.quiet.includes(this.channels[this.index]);
  }

  public reset(): void {
    this.index = 0;
  }
}
