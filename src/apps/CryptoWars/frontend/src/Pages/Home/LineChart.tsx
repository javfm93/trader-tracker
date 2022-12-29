import * as React from 'react';
import { ResponsiveLine } from '@nivo/line';

export function LineChart({ data }: { data: Array<{ x: string; y: string }> }) {
  const commonProperties = {
    height: 400,
    margin: { top: 20, right: 40, bottom: 40, left: 40 },
    animate: true,
    enableSlices: 'x'
  };
  return (
    <ResponsiveLine
      {...commonProperties}
      data={[
        {
          id: 'BUNNY',
          data: data
        }
      ]}
      xScale={{
        type: 'time',
        format: '%d/%m/%Y',
        useUTC: false,
        precision: 'day'
      }}
      xFormat="time:%d/%m/%Y"
      yScale={{
        type: 'linear',
        min: -200,
        max: +200
      }}
      axisLeft={{
        legend: 'linear scale',
        legendOffset: 12
      }}
      axisBottom={{
        format: '%b %d',
        tickValues: 'every 7 days',
        legend: 'time scale',
        legendOffset: -12
      }}
      enablePointLabel={true}
      pointSize={16}
      pointBorderWidth={1}
      pointBorderColor={{
        from: 'color',
        modifiers: [['darker', 0.3]]
      }}
      useMesh={true}
      enableSlices={false}
    />
  );
}
