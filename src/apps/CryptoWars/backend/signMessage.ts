import { createHmac } from 'crypto';
import { credentials } from './apikey';

export async function signMessage(message: string, secret: string): Promise<string> {
  const hmac = createHmac('sha256', secret).update(message);
  return hmac.digest().toString('base64');
}

interface SignedRequest<T extends object | undefined = {}> {
  originalParams: T;
  paramsWithSign?: T & { sign: string };
  serializedParams: string;
  sign: string;
  queryParamsWithSign: string;
  timestamp: number;
  recvWindow: number;
}

export async function signRequest<T extends object | undefined = {}>(
  data: T,
  endpoint: string
): Promise<SignedRequest<T>> {
  const timestamp = Date.now();
  const res: SignedRequest<T> = {
    originalParams: {
      ...data
    },
    sign: '',
    timestamp,
    recvWindow: 0,
    serializedParams: '',
    queryParamsWithSign: ''
  };
  const signRequestParams = serializeParams(data);
  const paramsStr = timestamp + 'GET' + endpoint + signRequestParams;

  res.sign = await signMessage(paramsStr, credentials.secretKey ?? '');
  res.queryParamsWithSign = signRequestParams;
  return res;
}

export function serializeParams<T extends object | undefined = {}>(
  params: T,
  strictValidation = false,
  prefixWith: string = '?'
): string {
  if (!params) {
    return '';
  }

  const queryString = Object.keys(params)
    .sort()
    .map(key => {
      // @ts-ignore
      const value = params[key];
      if (strictValidation === true && typeof value === 'undefined') {
        throw new Error('Failed to sign API request due to undefined parameter');
      }
      return `${key}=${value}`;
    })
    .join('&');

  return queryString ? prefixWith + queryString : queryString;
}

export const getSignedGet = (
  startTime: string,
  endTime: string,
  pageSize: string,
  isPre: boolean
) => {
  const apiSecret = credentials.secretKey ?? '';
  const url = 'https://api.bitget.com'; // host
  const uri = '/api/mix/v1/order/historyProductType'; // path;
  const method = 'GET';
  const expires = Date.now();
  const body = `?productType=umcbl&startTime=${startTime}&endTime=${endTime}&pageSize=${pageSize}&isPre=${isPre}`;
  //set params
  // pm.variables.set("timestamp", expires);
  const requestUrl = url + uri + body;
  const message = expires + method + uri + body;

  //console.info(sign-value:+message)
  //console.info(request-url:+requestUrl)
  // pm.request.url = requestUrl;
  const hmac = createHmac('sha256', apiSecret).update(message);
  const base64 = hmac.digest().toString('base64');
  return { base64, requestUrl, timestamp: expires };
  // pm.variables.set("sign:", base64);
  //console.info(sign:+base64)
};
