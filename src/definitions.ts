export interface CapLinkingPlugin {
  openURL(options: { url: string }): Promise<void>;
  canOpenURL(options: { url: string }): Promise<{ canOpen: boolean }>;
}
