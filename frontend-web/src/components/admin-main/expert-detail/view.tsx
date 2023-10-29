import { useAdminExpertDetailViewController } from "@components/admin-main/expert-detail/view.controller.ts";
import * as S from "./style.ts";
import { EJob } from "@type/job.ts";
import { EFacilityType } from "@type/facility-type.ts";
import { getDateStringFromArray } from "@util/get-date-string-from-array.ts";
import ApprovalDialog from "@components/admin-main/approval-dialog/view.tsx";

function AdminExpertDetail() {
  const {
    expertDetail,
    isLoading,
    openApprovalDialog,
    approvalDialogOpen,
    onCloseApprovalDialog,
    onClickOkayOnApprovalDialog,
    openRejectionDialog,
    rejectionDialogOpen,
    onCloseRejectionDialog,
    onClickOkayOnRejectionDialog,
    rejectionReason,
    onChangeRejectionReason,
  } = useAdminExpertDetailViewController();

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
      <S.InnerDiv>
        <S.HeaderSpan>{"전문가 정보"}</S.HeaderSpan>
        <S.OneItemSpan>
          <S.NameSpan>{"성함"}</S.NameSpan>
          <S.NormalSpan>{name}</S.NormalSpan>
        </S.OneItemSpan>
        <S.OneItemSpan>
          <S.NameSpan>{"연락처"}</S.NameSpan>
          <S.NormalSpan>{expertTel}</S.NormalSpan>
        </S.OneItemSpan>
        <S.OneItemSpan>
          <S.NameSpan>{"직종"}</S.NameSpan>
          <S.NormalSpan>{jobType === EJob.DOCTOR ? "의사" : "약사"}</S.NormalSpan>
        </S.OneItemSpan>
        <S.Bar />
        <S.HeaderSpan>{"소속 기관 정보"}</S.HeaderSpan>
        <S.BelongInfoDiv>
          <S.BelongInnerDiv>
            <S.OneItemSpan>
              <S.NameSpan>{"기관명"}</S.NameSpan>
              <S.NormalSpan>{facilityName}</S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"요양기관 번호"}</S.NameSpan>
              <S.NormalSpan>{facilityNumber}</S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"기관 종류"}</S.NameSpan>
              <S.NormalSpan>{facilityType === EFacilityType.HOSPITAL ? "병원" : "약국"}</S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"기관장 성함"}</S.NameSpan>
              <S.NormalSpan>{chiefName}</S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"기관장 연락처"}</S.NameSpan>
              <S.NormalSpan>{chiefTel}</S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"기관 우편번호"}</S.NameSpan>
              <S.NormalSpan>{zipCode}</S.NormalSpan>
            </S.OneItemSpan>
          </S.BelongInnerDiv>
          <S.BelongInnerDiv>
            <S.OneItemSpan>
              <S.NameSpan>{"기관 주소"}</S.NameSpan>
              <S.NormalSpan>{address}</S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"사업자등록번호"}</S.NameSpan>
              <S.NormalSpan>{businessRegiNumber}</S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"기관 연락처"}</S.NameSpan>
              <S.NormalSpan>{facilityTel ?? "기관 연락처 정보가 없습니다."}</S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"운영 시간"}</S.NameSpan>
              <S.NormalSpan>{clinicHours ?? "운영 시간 정보가 없습니다."}</S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"기관 특징"}</S.NameSpan>
              <S.NormalSpan>{features ?? "기관 특징 정보가 없습니다."}</S.NormalSpan>
            </S.OneItemSpan>
          </S.BelongInnerDiv>
        </S.BelongInfoDiv>
        <S.Bar />
        <S.HeaderSpan>{"전문가 인증 정보"}</S.HeaderSpan>
        <S.ImgDiv>
          <S.InnerImgDiv>
            <img alt={"certificateImg"} />
          </S.InnerImgDiv>
          <S.InnerImgDiv>
            <img alt={"affiliationImg"} />
          </S.InnerImgDiv>
        </S.ImgDiv>
        <S.OneItemSpan>
          <S.NameSpan>{"신청일"}</S.NameSpan>
          <S.NormalSpan>{getDateStringFromArray(requestedAt)}</S.NormalSpan>
        </S.OneItemSpan>
      </S.InnerDiv>
      <S.BottomButtonDiv>
        <S.RejectionButton onClick={openRejectionDialog}>거절</S.RejectionButton>
        <S.ApprovalButton onClick={openApprovalDialog}>승인</S.ApprovalButton>
      </S.BottomButtonDiv>
      <ApprovalDialog
        title={"정말 본 사용자를 전문가로 승인하시겠습니까?"}
        isOpen={approvalDialogOpen}
        onClose={onCloseApprovalDialog}
        onClickOkay={onClickOkayOnApprovalDialog}
        hasReasonForm={false}
      />
      <ApprovalDialog
        title={"정말 본 사용자의 승인 요청을 거절하시겠습니까?"}
        isOpen={rejectionDialogOpen}
        onClose={onCloseRejectionDialog}
        onClickOkay={onClickOkayOnRejectionDialog}
        hasReasonForm={true}
        reason={rejectionReason}
        onChangeReason={onChangeRejectionReason}
      />
    </S.OuterDiv>
  );
}

export default AdminExpertDetail;
