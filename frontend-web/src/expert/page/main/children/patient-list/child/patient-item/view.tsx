import * as S from "./style.ts";

import MaleOutlinedIcon from "@mui/icons-material/MaleOutlined";
import FemaleOutlinedIcon from "@mui/icons-material/FemaleOutlined";
import { useMediaQuery } from "react-responsive";
import { ESex } from "../../../../../../type/sex.ts";
import getAge from "../../../../../../util/get-age.ts";

type PatientItemProps = {
  patientInfo: {
    id: number;
    profileImg: string;
    name: string;
    sex: string;
    birthday: number[];
    tel: string;
    lastQuestionnaireDate: number[];
    isManaged: boolean;
  };
  onClickToManage: () => void;
  onClickToNotManage: () => void;
};

function PatientItem({ patientInfo, onClickToManage, onClickToNotManage }: PatientItemProps) {
  const isMiddleMobile = useMediaQuery({ query: "(max-width: 671px)" });

  const { id, profileImg, name, sex, birthday, tel, lastQuestionnaireDate, isManaged } = patientInfo;

  const dateDiff = Math.floor(
    (Date.now() -
      new Date(lastQuestionnaireDate[0], lastQuestionnaireDate[1] - 1, lastQuestionnaireDate[2]).getTime()) /
      (1000 * 60 * 60 * 24),
  );

  return (
    <S.OuterDiv>
      <S.StyledLink to={`/expert/patient/${id}`}>
        <S.ProfileImg src={profileImg === "" ? "/src/expert/assets/icons/no-profile-icon.png" : profileImg} />
        <S.NameSpan>
          {name.length > 4 ? name.substring(0, 4) + "..." : name}
          {isMiddleMobile && (sex === ESex.MALE ? <MaleOutlinedIcon /> : <FemaleOutlinedIcon />)}
        </S.NameSpan>
        <S.SexBirthdaySpan>
          {`(`}
          {sex === ESex.MALE ? "남성" : "여성"}
          {sex === ESex.MALE ? <MaleOutlinedIcon /> : <FemaleOutlinedIcon />}
          {`, ${getAge(new Date(birthday[0], birthday[1] - 1, birthday[2]))}세)`}
        </S.SexBirthdaySpan>
        <S.TelephoneSpan>{tel}</S.TelephoneSpan>
        <S.LastQuestionnaireDateSpan>
          {`${lastQuestionnaireDate[0]}.
          ${lastQuestionnaireDate[1] < 10 ? "0".concat(lastQuestionnaireDate[1].toString()) : lastQuestionnaireDate[1]}.
          ${
            lastQuestionnaireDate[2] < 10 ? "0".concat(lastQuestionnaireDate[2].toString()) : lastQuestionnaireDate[2]
          }.`}
          {dateDiff > 365
            ? ` (${Math.floor(dateDiff / 365)}년 전)`
            : dateDiff > 30
            ? ` (${Math.floor(dateDiff / 30)}개월 전)`
            : ` (${dateDiff}일 전)`}
        </S.LastQuestionnaireDateSpan>
      </S.StyledLink>
      <S.StyledIconButton onClick={isManaged ? onClickToNotManage : onClickToManage}>
        <S.StyledStarIcon className={isManaged ? "managed" : "unmanaged"} />
      </S.StyledIconButton>
    </S.OuterDiv>
  );
}

export default PatientItem;
