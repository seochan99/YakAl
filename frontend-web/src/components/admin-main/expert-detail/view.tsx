import { useAdminExpertDetailViewController } from "@components/admin-main/expert-detail/view.controller.ts";
import * as S from "./style.ts";

function AdminExpertDetail() {
  const { expertDetail, isLoading } = useAdminExpertDetailViewController();

  if (isLoading || expertDetail == null) {
    return <></>;
  }

  const {
    belongInfo: {
      type: facilityType,
      chiefName,
      chiefTel,
      facilityName,
      facilityNumber,
      zipCode,
      address,
      businessRegiNumber,
      tel: facilityTel,
      clinicHours,
      features,
    },
    name,
    tel: expertTel,
    requestedAt,
    type: jobType,
    certificateImg,
    affiliationImg,
  } = expertDetail;

  return (
    <S.OuterDiv>
      <S.HeaderDiv>
        <S.BackLink to="/admin/main">
          <S.StyledLinkIconSvg />
          목록으로
        </S.BackLink>
      </S.HeaderDiv>
      <S.BodyDiv>
        <S.InnerDiv>{name}</S.InnerDiv>
      </S.BodyDiv>
    </S.OuterDiv>
  );
}

export default AdminExpertDetail;
