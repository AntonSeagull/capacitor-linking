import { WebPlugin } from '@capacitor/core';

import type { CapLinkingPlugin } from './definitions';

export class CapLinkingWeb extends WebPlugin implements CapLinkingPlugin {
  async openURL(options: { url: string }): Promise<void> {
    const { url } = options;
    window.open(url, '_blank');
  }

  async canOpenURL(options: { url: string }): Promise<{ canOpen: boolean }> {
    const { url } = options;
    try {
      const response = await fetch(url, { method: 'HEAD' });
      return { canOpen: response.ok };
    } catch {
      return { canOpen: false };
    }
  }
}
