import { TradesTable } from './TradesTable';
import { useHistoryOrders } from './useHistoryOrders';

export const Home = (): JSX.Element => {
  const { result, isLoading } = useHistoryOrders();

  if (isLoading) {
    return <> im loading</>;
  }
  if (!isLoading && !result) {
    return <>An error happen</>;
  }

  return <TradesTable trades={result} />;
};
