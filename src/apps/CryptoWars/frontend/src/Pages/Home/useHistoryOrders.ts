import { useQuery } from 'react-query';
import { handleQueryResult, QueryTrigger } from '../../API/query';
import axios from 'axios';

interface HistoryOrdersResponse {
  orders: Trades;
}

export type Trades = Array<Trade>;

export interface Trade {
  symbol: string;
  size: number;
  orderId: string;
  fee: number;
  state: string; // filled
  side: string; // close_short
  marginCoin: string; // USDT
  filledAmount: number;
  orderType: string; // limit
  leverage: string;
  marginMode: string; // crossed
  cTime: string; // unix timestamp
  uTime: string; // unix timestamp
  totalProfits: number;
  posSide: string; // short / long
}

export const useHistoryOrders: QueryTrigger<void, Trades> = () => {
  const getHistoryOrders = async (): Promise<Trades> => {
    const response = await axios.get<HistoryOrdersResponse>(`http://localhost:5000/history`);
    console.log(response.data);

    return response.data.orders
      .filter(trade => trade.totalProfits !== 0)
      .sort((trade1, trade2) => parseInt(trade1.uTime) - parseInt(trade2.uTime));
  };
  return handleQueryResult<Trades>(useQuery('tradesHistory', getHistoryOrders));
};
