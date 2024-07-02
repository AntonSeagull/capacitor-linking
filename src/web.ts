import { WebPlugin } from '@capacitor/core';

import type { CapLinkingPlugin } from './definitions';

export class CapLinkingWeb extends WebPlugin implements CapLinkingPlugin {
  async openURL(options: { url: string }): Promise<void> {
    const { url } = options;
    window.open(url, '_blank');
  }

  async canOpenURL(options: { url: string }): Promise<{ canOpen: boolean }> {
    const { url } = options;
    console.info('No implementation for web, returning true', url);
    return { canOpen: true };
  }
}
