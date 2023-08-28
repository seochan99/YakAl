import { ESex } from "@/type/sex";
import { DateBox, Name, Outer, Sex, TestProgress } from "./style";
import getAge from "@/util/get-age";
import { TUser } from "@/store/user";

import MaleOutlinedIcon from "@mui/icons-material/MaleOutlined";
import FemaleOutlinedIcon from "@mui/icons-material/FemaleOutlined";
import { useEffect, useState } from "react";
import { useMediaQuery } from "react-responsive";

type PatientItemProps = {
  userInfo: TUser;
};

function PatientItem({ userInfo }: PatientItemProps) {
  const { id, name, sex, birthday, testProgress, submitDate } = userInfo;

  const [dateDiff, setDateDiff] = useState<number>(-1);

  const isMiddleMobile = useMediaQuery({ query: "(max-width: 592px)" });
  const isNarrowMobile = useMediaQuery({ query: "(max-width: 380px)" });

  useEffect(() => {
    setDateDiff(Math.floor((Date.now() - submitDate.getTime()) / (1000 * 60 * 60 * 24)));
  }, [submitDate]);

  return (
    <Outer to={`/patient/${id}`}>
      <Name>
        {name.length > 4 ? name.substring(0, 4) + "..." : name}
        {isMiddleMobile && (sex === ESex.MALE ? <MaleOutlinedIcon /> : <FemaleOutlinedIcon />)}
      </Name>
      {!isMiddleMobile && (
        <Sex>
          {sex === ESex.MALE ? "남성" : "여성"}
          {sex === ESex.MALE ? <MaleOutlinedIcon /> : <FemaleOutlinedIcon />}
        </Sex>
      )}
      <DateBox>
        {`${birthday.getFullYear()}.
          ${birthday.getMonth() + 1 < 10 ? "0".concat((birthday.getMonth() + 1).toString()) : birthday.getMonth() + 1}.
          ${birthday.getDate()}.`}
        {!isMiddleMobile && ` (${getAge(birthday)}세)`}
      </DateBox>
      {!isMiddleMobile && <TestProgress>{`${testProgress}%`}</TestProgress>}
      {!isNarrowMobile && (
        <DateBox>
          {`${submitDate.getFullYear()}.
          ${
            submitDate.getMonth() + 1 < 10
              ? "0".concat((submitDate.getMonth() + 1).toString())
              : submitDate.getMonth() + 1
          }.
          ${submitDate.getDate()}.`}
          {!isMiddleMobile &&
            (dateDiff > 365
              ? ` (${Math.floor(dateDiff / 365)}년 전)`
              : dateDiff > 30
              ? ` (${Math.floor(dateDiff / 30)}개월 전)`
              : ` (${dateDiff}일 전)`)}
        </DateBox>
      )}
    </Outer>
  );
}

export default PatientItem;
