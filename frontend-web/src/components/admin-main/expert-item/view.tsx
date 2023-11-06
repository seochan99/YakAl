import * as S from "./style.ts";
import { EJob } from "@type/enum/job.ts";
import LocalHospitalIcon from "@mui/icons-material/LocalHospital";
import LocalPharmacyIcon from "@mui/icons-material/LocalPharmacy";
import Tooltip from "@mui/material/Tooltip";
import { TAdminExpertItem } from "@type/response/admin-expert-item.ts";
import { getDateStringFromArray } from "@util/get-date-string-from-array.ts";

type TExpertItemProps = {
  expertInfo: TAdminExpertItem;
};

function AdminExpertItem({ expertInfo }: TExpertItemProps) {
  const { id, name, type, tel, belong, requestedAt } = expertInfo;

  return (
    <S.OuterDiv>
      <S.StyledLink to={`/admin/expert/${id}`}>
        <Tooltip title={name} followCursor>
          <S.NameSpan>{name}</S.NameSpan>
        </Tooltip>
        <S.JobTypeSpan>
          {type === EJob.DOCTOR ? (
            <>
              <LocalHospitalIcon />
              {"의사"}
            </>
          ) : (
            <>
              <LocalPharmacyIcon />
              {"약사"}
            </>
          )}
        </S.JobTypeSpan>
        <Tooltip title={belong} followCursor>
          <S.FacilityNameSpan>{belong}</S.FacilityNameSpan>
        </Tooltip>
        <S.TelephoneSpan>{tel}</S.TelephoneSpan>
        <S.RequestDateSpan>{getDateStringFromArray(requestedAt)}</S.RequestDateSpan>
      </S.StyledLink>
    </S.OuterDiv>
  );
}

export default AdminExpertItem;
