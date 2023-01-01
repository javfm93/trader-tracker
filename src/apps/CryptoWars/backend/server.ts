import bodyParser from 'body-parser';
import compress from 'compression';
import errorHandler from 'errorhandler';
import express, { Request, Response } from 'express';
import Router from 'express-promise-router';
import helmet from 'helmet';
import http from 'http';
import httpStatus from 'http-status';
import cors from 'cors';
import cookieParser from 'cookie-parser';
import { logger } from '../../../Contexts/Shared/Infrastructure/WinstonLogger';
import { getSignedGet } from './signMessage';
import { credentials } from './apikey';
import axios from 'axios';

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

export interface HistoryOrdersResponse {
  data: {
    orderList: Trades;
  };
}

export class Server {
  private express: express.Express;
  private port: string;
  private httpServer?: http.Server;

  constructor(port: string) {
    this.port = port;
    this.express = express();
    const corsConfig = {
      origin: 'http://localhost:3000',
      credentials: true
    };

    this.express.use(cors(corsConfig));
    this.express.use(bodyParser.json());
    this.express.use(bodyParser.urlencoded({ extended: true }));
    this.express.use(cookieParser());
    this.express.use(helmet.xssFilter());
    this.express.use(helmet.noSniff());
    this.express.use(helmet.hidePoweredBy());
    this.express.use(helmet.frameguard({ action: 'deny' }));
    this.express.use(compress());
    const router = Router();
    router.use(errorHandler());
    this.express.use(router);

    router.get('/', async (req: Request, res: Response) => {
      const env = process.env.BITGET_PASSWORD
        ? process.env.BITGET_PASSWORD.charAt(process.env.BITGET_PASSWORD.length - 1)
        : 'not env';
      res.status(httpStatus.OK).send('this is the root!' + env);
    });
    // registerRoutes(router);
    router.get('/history', async (req: Request, res: Response) => {
      const oneWeekAgo = new Date();
      oneWeekAgo.setHours(oneWeekAgo.getHours() - 24 * 7);
      const startTime = oneWeekAgo.getTime().toString();
      const endTime = Date.now().toString();
      const pageSize = '100';
      const url = 'https://api.bitget.com/api/mix/v1/order/historyProductType';
      const isPre = true;
      const signedRequest = getSignedGet(startTime, endTime, pageSize, isPre);
      const response = await axios.get<HistoryOrdersResponse>(
        `${url}?productType=umcbl&startTime=${startTime}&endTime=${endTime}&pageSize=${pageSize}&isPre=${isPre}`,
        {
          headers: {
            'X-CHANNEL-API-CODE': '3tem',
            'ACCESS-KEY': credentials.apikey ?? '',
            'ACCESS-PASSPHRASE': credentials.password ?? '',
            'ACCESS-TIMESTAMP': signedRequest.timestamp,
            'ACCESS-SIGN': signedRequest.base64,
            'Content-Type': 'application/json'
          }
        }
      );

      // todo: fetch more result until get last week
      res.status(httpStatus.OK).json({ orders: response.data.data.orderList });
    });

    router.use((err: Error, req: Request, res: Response, next: Function) => {
      logger.error(err.stack ?? new Error(err.message));
      res.status(httpStatus.INTERNAL_SERVER_ERROR).send();
    });
  }

  async listen(): Promise<void> {
    return new Promise(resolve => {
      const server = http.createServer(this.express);
      this.httpServer = server.listen(this.port, () => {
        logger.info(
          `Crypto Wars Backend App is running at http://localhost:${
            this.port
          } in ${this.express.get('env')} mode`
        );
        logger.info('Press CTRL-C to stop');
        resolve();
      });
    });
  }

  async stop(): Promise<void> {
    return new Promise((resolve, reject) => {
      if (this.httpServer) {
        this.httpServer.close(error => {
          if (error) {
            return reject(error);
          }
          return resolve();
        });
      }

      return resolve();
    });
  }
}
