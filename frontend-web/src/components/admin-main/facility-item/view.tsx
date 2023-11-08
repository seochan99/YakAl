import * as S from "./style.ts";
import { EFacilityType } from "@type/enum/facility-type.ts";
import LocalHospitalIcon from "@mui/icons-material/LocalHospital";
import LocalPharmacyIcon from "@mui/icons-material/LocalPharmacy";
import Tooltip from "@mui/material/Tooltip";
import { TAdminFacilityItem } from "@type/response/admin-facility-item.ts";
import { getDateStringFromArray } from "@util/get-date-string-from-array.ts";
import { formatTel } from "@util/format-tel.ts";

type TFacilityItemProps = {
  facilityInfo: TAdminFacilityItem;
};

function FacilityItem({ facilityInfo }: TFacilityItemProps) {
  const { id, name, directorName, directorTel, type, requestedAt } = facilityInfo;

  return (
    <S.OuterDiv>
      <S.StyledLink to={`/admin/facility/${id}`}>
        <Tooltip title={name} followCursor>
          <S.NameSpan>{name.length > 9 ? name.slice(0, 9) + "..." : name}</S.NameSpan>
        </Tooltip>
        <S.FacilityTypeSpan>
          {type === EFacilityType.HOSPITAL ? (
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
        <Tooltip title={directorName} followCursor>
          <S.RepresentativeSpan>{directorName}</S.RepresentativeSpan>
        </Tooltip>
        <S.TelephoneSpan>{formatTel(directorTel)}</S.TelephoneSpan>
        <S.RequestDateSpan>{getDateStringFromArray(requestedAt)}</S.RequestDateSpan>
      </S.StyledLink>
    </S.OuterDiv>
  );
}

export default FacilityItem;
