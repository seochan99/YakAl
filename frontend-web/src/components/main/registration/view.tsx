import * as S from "./style.ts";
import { EFacilityType } from "@type/facility-type.ts";
import { useRegistrationPageViewController } from "@components/main/registration/view.controller.ts";

export function RegistrationPage() {
  const {
    selected,
    isFinished,
    onClickHospital,
    onClickPharmacy,
    facilityDirectorName,
    onChangeFacilityDirectorName,
    directorPhoneNumber,
    onChangeDirectorPhoneName,
    facilityName,
    onChangeFacilityName,
    facilityNumber,
    onChangeFacilityNumber,
    facilityPostcode,
    onChangeFacilityPostcode,
    handleSearchPostCodeClick,
    facilityAddress,
    onChangeFacilityAddress,
    facilityAddressDetailRef,
    facilityAddressDetail,
    onChangeFacilityAddressDetail,
    facilityAddressExtra,
    onChangeFacilityAddressExtra,
    facilityBusinessNumber,
    onChangeFacilityBusinessNumber,
    imgFileName,
    handleCertImgChange,
    certificationImgPreviewRef,
    facilityContact,
    onChangeFacilityContact,
    facilityHours,
    onChangeFacilityHours,
    facilityFeatures,
    onChangeFacilityFeatures,
    handleSubmit,
  } = useRegistrationPageViewController();

  return (
    <S.Outer>
      <S.Header>
        <S.BackButton to="/expert">
          <S.BackIcon />
          대시 보드로
        </S.BackButton>
        <S.ProgressBarWrapper>
          <S.ProgressBar className={selected !== null ? "on" : "off"} />
          <S.ProgressBar className={selected !== null && isFinished ? "on" : "off"} />
          <S.ProgressText>{selected === null ? "0 / 2" : isFinished ? "2 / 2" : "1 / 2"}</S.ProgressText>
        </S.ProgressBarWrapper>
      </S.Header>
      <S.InnerBox>
        <S.Title>기관 등록 페이지입니다.</S.Title>
        <S.Subtitle>
          1. 본인이 장으로 있는 요양 기관을 약 알에 등록하면 해당 기관의 전문가 분들이 본 서비스를 이용하실 수 있습니다.
          등록하려는 기관이 병원인지 약국인지 선택해주세요.
        </S.Subtitle>
        <S.SelectButtonWrapper>
          <S.SelectButtonBox
            className={selected === EFacilityType.HOSPITAL ? "selected" : "unselected"}
            onClick={onClickHospital}
          >
            <S.HospitalIcon />
            병원
          </S.SelectButtonBox>
          <S.SelectButtonBox
            className={selected === EFacilityType.PHARMACY ? "selected" : "unselected"}
            onClick={onClickPharmacy}
          >
            <S.PharmacyIcon />
            약국
          </S.SelectButtonBox>
        </S.SelectButtonWrapper>
        {selected !== null && (
          <>
            <S.Subtitle>2. 기관 등록에 필요한 정보를 입력해주세요.</S.Subtitle>
            <S.InputBox>
              <S.CertInputBox>
                <S.CertInputLabel>{selected === EFacilityType.HOSPITAL ? "병원장명*" : "약국장명*"}</S.CertInputLabel>
                <S.CertInput type="text" value={facilityDirectorName} onChange={onChangeFacilityDirectorName} />
              </S.CertInputBox>
              <S.CertInputBox>
                <S.CertInputLabel>
                  {selected === EFacilityType.HOSPITAL ? "병원장 연락처(휴대폰)*" : "약국장 연락처(휴대폰)*"}
                </S.CertInputLabel>
                <S.CertInput type="tel" value={directorPhoneNumber} onChange={onChangeDirectorPhoneName} />
              </S.CertInputBox>
              <S.CertInputBox>
                <S.CertInputLabel>
                  {selected === EFacilityType.HOSPITAL ? "병원명(요양기관명)*" : "약국명(요양기관명)*"}
                </S.CertInputLabel>
                <S.CertInput type="text" value={facilityName} onChange={onChangeFacilityName} />
              </S.CertInputBox>
              <S.CertInputBox>
                <S.CertInputLabel>요양기관번호*</S.CertInputLabel>
                <S.CertInput type="text" value={facilityNumber} onChange={onChangeFacilityNumber} />
              </S.CertInputBox>
              <S.CertPostcodeInputBox>
                <S.CertInputBox>
                  <S.CertInputLabel>기관 우편번호*</S.CertInputLabel>
                  <S.PostcodeBox>
                    <S.CertInput type="text" value={facilityPostcode} onChange={onChangeFacilityPostcode} />
                    <S.PostcodeSearchButton onClick={handleSearchPostCodeClick}>우편번호 찾기</S.PostcodeSearchButton>
                  </S.PostcodeBox>
                </S.CertInputBox>
                <S.CertInputBox>
                  <S.CertInputLabel>
                    {selected === EFacilityType.HOSPITAL ? "병원 주소*" : "약국 주소*"}
                  </S.CertInputLabel>
                  <S.CertInput type="text" value={facilityAddress} onChange={onChangeFacilityAddress} />
                </S.CertInputBox>
                <S.CertAddressFooter>
                  <S.CertInputBox>
                    <S.CertInputLabel>상세 주소</S.CertInputLabel>
                    <S.CertInput
                      type="text"
                      ref={facilityAddressDetailRef}
                      value={facilityAddressDetail}
                      onChange={onChangeFacilityAddressDetail}
                    />
                  </S.CertInputBox>
                  <S.CertInputBox>
                    <S.CertInputLabel>참고 항목</S.CertInputLabel>
                    <S.CertInput type="text" value={facilityAddressExtra} onChange={onChangeFacilityAddressExtra} />
                  </S.CertInputBox>
                </S.CertAddressFooter>
              </S.CertPostcodeInputBox>
              <S.CertInputBox>
                <S.CertInputLabel>사업자 번호*</S.CertInputLabel>
                <S.CertInput type="text" value={facilityBusinessNumber} onChange={onChangeFacilityBusinessNumber} />
              </S.CertInputBox>
              <S.CertImgBox>
                <S.CertInputLabel>자격증 사진*</S.CertInputLabel>
                <S.CertInputImgBox>
                  <input readOnly={true} type="text" value={imgFileName} placeholder="첨부파일" />
                  <label htmlFor="file">파일찾기</label>
                  <input
                    type="file"
                    accept="image/jpg,impge/png,image/jpeg,image/gif"
                    id="file"
                    name="cerification_img"
                    onChange={handleCertImgChange}
                  />
                </S.CertInputImgBox>
                <S.CertImgPreview ref={certificationImgPreviewRef} />
              </S.CertImgBox>
              <S.CertInputBox>
                <S.CertInputLabel>
                  {selected === EFacilityType.HOSPITAL ? "병원 연락처(선택)" : "약국 연락처(선택)"}
                </S.CertInputLabel>
                <S.CertInput type="text" value={facilityContact} onChange={onChangeFacilityContact} />
              </S.CertInputBox>
              {/*<S.CertInputBox>*/}
              {/*  <S.CertInputLabel>정보 수정 수신 방법*</S.CertInputLabel>*/}
              {/*  <S.InfoTakeRadioBox>*/}
              {/*    <label>*/}
              {/*      <input*/}
              {/*        type="radio"*/}
              {/*        name="info-take"*/}
              {/*        value={informationTakenWay}*/}
              {/*        checked={informationTakenWay !== undefined ? informationTakenWay === EInfoTake.EMAIL : false}*/}
              {/*        onChange={() => setInformationTakenWay(EInfoTake.EMAIL)}*/}
              {/*      />*/}
              {/*      <span>이메일</span>*/}
              {/*    </label>*/}
              {/*    <label>*/}
              {/*      <input*/}
              {/*        type="radio"*/}
              {/*        name="info-take"*/}
              {/*        value={informationTakenWay}*/}
              {/*        checked={informationTakenWay !== undefined ? informationTakenWay === EInfoTake.PHONE : false}*/}
              {/*        onChange={() => setInformationTakenWay(EInfoTake.PHONE)}*/}
              {/*      />*/}
              {/*      <span>휴대폰</span>*/}
              {/*    </label>*/}
              {/*    <label>*/}
              {/*      <input*/}
              {/*        type="radio"*/}
              {/*        name="info-take"*/}
              {/*        value={informationTakenWay}*/}
              {/*        checked={informationTakenWay !== undefined ? informationTakenWay === EInfoTake.NONE : false}*/}
              {/*        onChange={() => setInformationTakenWay(EInfoTake.NONE)}*/}
              {/*      />*/}
              {/*      <span>받지 않음</span>*/}
              {/*    </label>*/}
              {/*  </S.InfoTakeRadioBox>*/}
              {/*</S.CertInputBox>*/}
              <S.CertInputBoxHours>
                <S.CertInputLabel>운영 시간(선택)</S.CertInputLabel>
                <S.CertInput type="text" value={facilityHours} onChange={onChangeFacilityHours} />
              </S.CertInputBoxHours>
              <S.CertInputBoxFeatures>
                <S.CertInputLabel>
                  {selected === EFacilityType.HOSPITAL ? "병원 특징(선택)" : "약국 특징(선택)"}
                </S.CertInputLabel>
                <S.CertTextarea value={facilityFeatures} onChange={onChangeFacilityFeatures} />
              </S.CertInputBoxFeatures>
            </S.InputBox>
          </>
        )}
      </S.InnerBox>
      <S.NextButton
        className={selected !== null && isFinished ? "is-finished" : ""}
        disabled={!(selected !== null && isFinished)}
        onClick={handleSubmit}
      >
        다음
      </S.NextButton>
    </S.Outer>
  );
}
