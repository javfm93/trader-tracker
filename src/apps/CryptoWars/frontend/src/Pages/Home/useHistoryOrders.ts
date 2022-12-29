import { useQuery } from 'react-query';
import { handleQueryResult, QueryTrigger } from '../../API/query';
import axios from 'axios';
import { Trades } from '../../../../backend/server';

interface HistoryOrdersResponse {
  orders: Trades;
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
