import * as S from "./style.ts";
import { EJob } from "@type/job.ts";
import { getDateStringFromDate } from "@util/get-date-string-from-date.ts";
import { TExpertItem } from "@store/admin-expert-list.ts";
import LocalHospitalIcon from "@mui/icons-material/LocalHospital";
import LocalPharmacyIcon from "@mui/icons-material/LocalPharmacy";
import Tooltip from "@mui/material/Tooltip";

type TExpertItemProps = {
  expertInfo: TExpertItem;
};

function AdminExpertItem({ expertInfo }: TExpertItemProps) {
  const { id, name, job, tel, belongName, requestedAt } = expertInfo;

  return (
    <S.OuterDiv>
      <S.StyledLink to={`/admin/expert/${id}`}>
        <Tooltip title={name} followCursor>
          <S.NameSpan>{name}</S.NameSpan>
        </Tooltip>
        <S.JobTypeSpan>
          {job === EJob.DOCTOR ? (
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
        <Tooltip title={belongName} followCursor>
          <S.FacilityNameSpan>{belongName}</S.FacilityNameSpan>
        </Tooltip>
        <S.TelephoneSpan>{tel}</S.TelephoneSpan>
        <S.RequestDateSpan>{getDateStringFromDate(requestedAt)}</S.RequestDateSpan>
      </S.StyledLink>
    </S.OuterDiv>
  );
}

export default AdminExpertItem;
