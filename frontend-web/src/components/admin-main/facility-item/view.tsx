import * as S from "./style.ts";
import { EFacilityType } from "@type/facility-type.ts";

type TFacilityItemProps = {
  facilityInfo: {
    id: number;
    name: string;
    representative: string;
    representativeTel: string;
    facilityType: EFacilityType;
    requested_at: Date;
  };
};

function FacilityItem({ facilityInfo }: TFacilityItemProps) {
  const { id, name, representative, representativeTel, facilityType, requested_at } = facilityInfo;

  const dateDiff = Math.floor((Date.now() - requested_at.getTime()) / (1000 * 60 * 60 * 24));

  return (
    <S.OuterDiv>
      <S.StyledLink to={`/admin/facility/${id}`}>
        <S.NameSpan>{name.length > 4 ? name.substring(0, 4) + "..." : name}</S.NameSpan>
        <S.SexBirthdaySpan>{facilityType == EFacilityType.HOSPITAL ? "(병원)" : "(약국)"}</S.SexBirthdaySpan>
        <S.TelephoneSpan>{representative}</S.TelephoneSpan>
        <S.TelephoneSpan>{representativeTel}</S.TelephoneSpan>
        <S.LastQuestionnaireDateSpan>
          {`${requested_at.getFullYear()}.
          ${requested_at.getMonth() < 10 ? "0".concat(requested_at.getMonth().toString()) : requested_at.getMonth()}.
          ${requested_at.getDate() < 10 ? "0".concat(requested_at.getDate().toString()) : requested_at.getDate()}.`}
          {dateDiff > 365
            ? ` (${Math.floor(dateDiff / 365)}년 전)`
            : dateDiff > 30
            ? ` (${Math.floor(dateDiff / 30)}개월 전)`
            : ` (${dateDiff}일 전)`}
        </S.LastQuestionnaireDateSpan>
      </S.StyledLink>
    </S.OuterDiv>
  );
}

export default FacilityItem;
