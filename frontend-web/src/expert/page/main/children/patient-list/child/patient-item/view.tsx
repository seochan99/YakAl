import * as S from "./style.ts";

import MaleOutlinedIcon from "@mui/icons-material/MaleOutlined";
import FemaleOutlinedIcon from "@mui/icons-material/FemaleOutlined";
import { useMediaQuery } from "react-responsive";
import { ESex } from "../../../../../../type/sex.ts";
import getAge from "../../../../../../util/get-age.ts";

type PatientItemProps = {
  userInfo?: {
    id: number;
    name: string;
    sex: string;
    birthday: number[];
    testProgress: number;
    lastSurbey: number[];
  };
};

function PatientItem({ userInfo }: PatientItemProps) {
  const isMiddleMobile = useMediaQuery({ query: "(max-width: 671px)" });

  if (!userInfo) {
    return <S.DummyOuter />;
  }

  const { id, name, sex, birthday, testProgress, lastSurbey } = userInfo;

  const dateDiff = Math.floor(
    (Date.now() - new Date(lastSurbey[0], lastSurbey[1] - 1, lastSurbey[2]).getTime()) / (1000 * 60 * 60 * 24),
  );

  return (
    <S.Outer
      to={`/expert/patient/${id}`}
      state={{
        id,
        name,
        sex: ESex[sex as keyof typeof ESex],
        birthday,
      }}
    >
      <S.Name>
        {name.length > 4 ? name.substring(0, 4) + "..." : name}
        {isMiddleMobile && (sex === ESex.MALE ? <MaleOutlinedIcon /> : <FemaleOutlinedIcon />)}
      </S.Name>
      {!isMiddleMobile && (
        <S.Sex>
          {sex === ESex.MALE ? "남성" : "여성"}
          {sex === ESex.MALE ? <MaleOutlinedIcon /> : <FemaleOutlinedIcon />}
        </S.Sex>
      )}
      <S.DateBox>
        {`${birthday[0]}.
          ${birthday[1] < 10 ? "0".concat(birthday[1].toString()) : birthday[1]}.
          ${birthday[2] < 10 ? "0".concat(birthday[2].toString()) : birthday[2]}.`}
        {!isMiddleMobile && ` (${getAge(new Date(birthday[0], birthday[1] - 1, birthday[2]))}세)`}
      </S.DateBox>
      {!isMiddleMobile && <S.TestProgress>{`${testProgress}%`}</S.TestProgress>}
      <S.DateBox>
        {`${lastSurbey[0]}.
          ${lastSurbey[1] < 10 ? "0".concat(lastSurbey[1].toString()) : lastSurbey[1]}.
          ${lastSurbey[2] < 10 ? "0".concat(lastSurbey[2].toString()) : lastSurbey[2]}.`}
        {!isMiddleMobile &&
          (dateDiff > 365
            ? ` (${Math.floor(dateDiff / 365)}년 전)`
            : dateDiff > 30
            ? ` (${Math.floor(dateDiff / 30)}개월 전)`
            : ` (${dateDiff}일 전)`)}
      </S.DateBox>
    </S.Outer>
  );
}

export default PatientItem;
