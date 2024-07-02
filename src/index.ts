import { registerPlugin } from '@capacitor/core';

import type { CapLinkingPlugin } from './definitions';

const CapLinking = registerPlugin<CapLinkingPlugin>('CapLinking', {
  web: () => import('./web').then(m => new m.CapLinkingWeb()),
});

export * from './definitions';
export { CapLinking };
