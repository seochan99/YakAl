import * as S from "./style.ts";
import { EFacilityType } from "@type/enum/facility-type.ts";
import { getDateStringFromArray } from "@util/get-date-string-from-array.ts";
import ApprovalDialog from "@components/admin-main/approval-dialog/view.tsx";
import { useAdminFacilityDetailViewController } from "@components/admin-main/facility-detail/view.controller.ts";

function AdminFacilityDetail() {
  const {
    facilityDetail,
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
  } = useAdminFacilityDetailViewController();

  if (isLoading || facilityDetail == null) {
    return <></>;
  }

  const {
    type,
    chiefName,
    chiefTel,
    facilityName,
    facilityNumber,
    zipCode,
    address,
    businessRegiNumber,
    certificateImg,
    tel,
    clinicHours,
    features,
    requestedAt,
  } = facilityDetail;

  return (
    <S.OuterDiv>
      <S.HeaderDiv>
        <S.BackLink to="/admin">
          <S.StyledLinkIconSvg />
          목록으로
        </S.BackLink>
      </S.HeaderDiv>
      <S.InnerDiv>
        <S.HeaderSpan>{"기관장 정보"}</S.HeaderSpan>
        <S.OneItemSpan>
          <S.NameSpan>{"성함"}</S.NameSpan>
          <S.NormalSpan>{chiefName}</S.NormalSpan>
        </S.OneItemSpan>
        <S.OneItemSpan>
          <S.NameSpan>{"연락처"}</S.NameSpan>
          <S.NormalSpan>{chiefTel}</S.NormalSpan>
        </S.OneItemSpan>
        <S.Bar />
        <S.HeaderSpan>{"기관 정보"}</S.HeaderSpan>
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
              <S.NormalSpan>{type === EFacilityType.HOSPITAL ? "병원" : "약국"}</S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"기관 우편번호"}</S.NameSpan>
              <S.NormalSpan>{zipCode}</S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"기관 주소"}</S.NameSpan>
              <S.NormalSpan>{address}</S.NormalSpan>
            </S.OneItemSpan>
          </S.BelongInnerDiv>
          <S.BelongInnerDiv>
            <S.OneItemSpan>
              <S.NameSpan>{"사업자등록번호"}</S.NameSpan>
              <S.NormalSpan>{businessRegiNumber}</S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"기관 연락처"}</S.NameSpan>
              <S.NormalSpan>{tel === null || tel === "" ? "기관 연락처 정보가 없습니다." : tel}</S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"운영 시간"}</S.NameSpan>
              <S.NormalSpan>
                {clinicHours === null || clinicHours === "" ? "운영 시간 정보가 없습니다." : clinicHours}
              </S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"기관 특징"}</S.NameSpan>
              <S.NormalSpan>
                {features === null || features === "" ? "기관 특징 정보가 없습니다." : features}
              </S.NormalSpan>
            </S.OneItemSpan>
          </S.BelongInnerDiv>
        </S.BelongInfoDiv>
        <S.Bar />
        <S.HeaderSpan>{"전문가 인증 정보"}</S.HeaderSpan>
        <S.ImgDiv>
          <S.InnerImgDiv>
            <img alt={"certificateImg"} src={`${import.meta.env.VITE_IMAGE_URL}/images/${certificateImg}`} />
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
        title={"정말 본 기관를 등록하시겠습니까?"}
        isOpen={approvalDialogOpen}
        onClose={onCloseApprovalDialog}
        onClickOkay={onClickOkayOnApprovalDialog}
        hasReasonForm={false}
      />
      <ApprovalDialog
        title={"정말 본 기관 등록 신청을 거절하시겠습니까?"}
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

export default AdminFacilityDetail;
