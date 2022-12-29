import { FC } from 'react';
import TableContainer from '@mui/material/TableContainer';
import Paper from '@mui/material/Paper';
import Table from '@mui/material/Table';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import TableCell from '@mui/material/TableCell';
import TableBody from '@mui/material/TableBody';
import { LineChart } from './LineChart';
import { Grid } from '@mui/material';

interface TradesProps {
  trades: Trades;
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

const formatFromTimeStampToChartDate = (timeStamp: string) =>
  new Date(parseInt(timeStamp)).toLocaleDateString();

export const TradesTable: FC<TradesProps> = ({ trades }) => {
  const earnedPerDay: Record<string, { x: string; y: string }> = {};
  const accumulatedPerDay: Record<string, { x: string; y: string }> = {};
  let accumulated = 0;
  for (const trade of trades) {
    const day = formatFromTimeStampToChartDate(trade.uTime);
    accumulated += trade.totalProfits;
    console.log('accumulated on', day, 'is: ', accumulated);
    if (day in earnedPerDay) {
      earnedPerDay[day] = {
        x: day,
        y: (parseFloat(earnedPerDay[day].y) + trade.totalProfits).toFixed(2)
      };
    } else {
      earnedPerDay[day] = { x: day, y: trade.totalProfits.toFixed(2) };
    }
    accumulatedPerDay[day] = {
      x: day,
      y: accumulated.toFixed(2)
    };
  }

  return (
    <Grid container spacing={2}>
      <Grid item xs={12} style={{ display: 'block' }}>
        <span>Earned each day</span>
        <LineChart data={Object.values(earnedPerDay)} />
      </Grid>
      <Grid item xs={12} style={{ display: 'block' }}>
        <span>Accumulated each day</span>
        <LineChart data={Object.values(accumulatedPerDay)} />
      </Grid>

      <Grid item xs={12}>
        <TableContainer component={Paper}>
          <Table sx={{ minWidth: 650 }} aria-label="simple table">
            <TableHead>
              <TableRow>
                <TableCell>Coin</TableCell>
                <TableCell>Date</TableCell>
                <TableCell>Profit</TableCell>
                <TableCell>Type</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {trades.map((trade, index) => (
                <TableRow
                  key={trade.cTime}
                  sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
                >
                  <TableCell component="th" scope="row">
                    {trade.symbol}
                  </TableCell>
                  <TableCell component="th" scope="row">
                    {formatFromTimeStampToChartDate(trade.uTime)}
                  </TableCell>
                  <TableCell component="th" scope="row">
                    {trade.totalProfits}
                  </TableCell>
                  <TableCell component="th" scope="row">
                    {trade.posSide}
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
      </Grid>
    </Grid>
  );
};
