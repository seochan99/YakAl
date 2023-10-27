import * as S from "./style.ts";
import { EFacilityType } from "@type/facility-type.ts";
import { getDateString } from "@util/get-date-string.ts";
import { TFacilityItem } from "@store/admin-facility-list.ts";
import LocalHospitalIcon from "@mui/icons-material/LocalHospital";
import LocalPharmacyIcon from "@mui/icons-material/LocalPharmacy";
import Tooltip from "@mui/material/Tooltip";

type TFacilityItemProps = {
  facilityInfo: TFacilityItem;
};

function FacilityItem({ facilityInfo }: TFacilityItemProps) {
  const { id, name, representative, representativeTel, facilityType, requestedAt } = facilityInfo;

  return (
    <S.OuterDiv>
      <S.StyledLink to={`/admin/facility/${id}`}>
        <Tooltip title={name} followCursor>
          <S.NameSpan>{name}</S.NameSpan>
        </Tooltip>
        <S.FacilityTypeSpan>
          {facilityType === EFacilityType.HOSPITAL ? (
            <>
              <LocalHospitalIcon />
              {"병원"}
            </>
          ) : (
            <>
              <LocalPharmacyIcon />
              {"약국"}
            </>
          )}
        </S.FacilityTypeSpan>
        <Tooltip title={representative} followCursor>
          <S.RepresentativeSpan>{representative}</S.RepresentativeSpan>
        </Tooltip>
        <S.TelephoneSpan>{representativeTel}</S.TelephoneSpan>
        <S.RequestDateSpan>{getDateString(requestedAt)}</S.RequestDateSpan>
      </S.StyledLink>
    </S.OuterDiv>
  );
}

export default FacilityItem;
