import { convertRemToPixels } from "../../../../../../../util/rem-to-px.ts";
import { CartesianGrid, Line, LineChart, Tooltip, TooltipProps, XAxis, YAxis } from "recharts";
import { NameType, ValueType } from "recharts/types/component/DefaultTooltipContent";
import moment from "moment";
import { useEffect, useState } from "react";

import * as S from "./style.ts";

type TARMSGraphProps = {
  arms: {
    score: number;
    createdAt: number[];
  }[];
};

function ARMSGraph({ arms }: TARMSGraphProps) {
  const [armsTime, setArmsTime] = useState<
    | {
        createdAt: number;
        score: number;
      }[]
    | null
  >(null);

  useEffect(() => {
    setArmsTime(
      arms.map((armsItem) => ({
        score: armsItem.score,
        createdAt: moment(
          `${armsItem.createdAt[0]}-${armsItem.createdAt[1] < 9 ? "0" : ""}${armsItem.createdAt[1]}-${
            armsItem.createdAt[2] < 9 ? "0" : ""
          }${armsItem.createdAt[2]}T00:00:00Z`,
        ).valueOf(),
      })),
    );
  }, [arms]);

  return (
    armsTime && (
      <LineChart
        width={convertRemToPixels(32)}
        height={convertRemToPixels(16)}
        data={armsTime}
        margin={{
          top: convertRemToPixels(1),
          right: convertRemToPixels(1),
          left: convertRemToPixels(1),
          bottom: convertRemToPixels(1.5),
        }}
      >
        <CartesianGrid strokeDasharray="3 3" />
        <XAxis
          label={{ value: "설문일", position: "insideBottom", offset: -convertRemToPixels(1) }}
          dataKey={"createdAt"}
          domain={[
            armsTime[0].createdAt - (armsTime[3].createdAt - armsTime[0].createdAt) / 6,
            armsTime[3].createdAt + (armsTime[3].createdAt - armsTime[0].createdAt) / 6,
          ]}
          ticks={armsTime.map((armsTimeItem) => armsTimeItem.createdAt)}
          scale={"time"}
          type={"number"}
          tickFormatter={(date) => {
            return moment(date).format("YYYY/MM/DD");
          }}
        />
        <YAxis
          label={{
            value: "ARMS 점수",
            angle: -90,
            position: "insideLeft",
          }}
          type={"number"}
          dataKey={"score"}
          domain={[-8, 56]}
          ticks={[0, 16, 32, 48]}
        />
        <Tooltip
          content={({ active, payload, label }: TooltipProps<ValueType, NameType>) => {
            if (active && payload && payload.length) {
              return (
                <S.TooltipDiv>
                  <span>
                    <S.BlackSpan>{`ARMS: `}</S.BlackSpan>
                    <S.BlueSpan>{`${payload[0].value}`}</S.BlueSpan>
                  </span>
                  <S.BlackSpan>{`설문일: ${moment(label).format("YYYY/MM/DD")}`}</S.BlackSpan>
                </S.TooltipDiv>
              );
            }

            return null;
          }}
          cursor={{ fill: "transparent" }}
        />
        <Line type="monotone" dataKey={"score"} stroke="#2666f6" activeDot={{ r: 6 }} />
      </LineChart>
    )
  );
}

export default ARMSGraph;
