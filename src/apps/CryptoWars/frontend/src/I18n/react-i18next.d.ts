import 'react-i18next';
import es from './es.json';

declare module 'react-i18next' {
  interface CustomTypeOptions {
    defaultNS: 'translation';
    resources: typeof es;
  }
}
