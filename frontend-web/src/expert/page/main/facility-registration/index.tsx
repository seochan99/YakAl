import {
  BackButton,
  BackIcon,
  CertAddressFooter,
  CertImgBox,
  CertImgPreview,
  CertInput,
  CertInputBox,
  CertInputBoxFeatures,
  CertInputBoxHours,
  CertInputImgBox,
  CertInputLabel,
  CertPostcodeInputBox,
  CertTextarea,
  Header,
  HospitalIcon,
  InfoTakeRadioBox,
  InnerBox,
  InputBox,
  NextButton,
  Outer,
  PharmacyIcon,
  PostcodeBox,
  PostcodeSearchButton,
  ProgressBar,
  ProgressBarWrapper,
  ProgressText,
  SelectButtonBox,
  SelectButtonWrapper,
  Subtitle,
  Title,
} from "./style.ts";
import React, { useEffect, useRef, useState } from "react";
import { EFacility } from "@/expert/type/facility.ts";
import { EInfoTake } from "@/expert/type/info-take.ts";
import { useRegisterImageMutation, useRegisterMutation } from "@/expert/api/registration.ts";
import { useNavigate } from "react-router-dom";

export function FacilityRegistration() {
  const [selected, setSelected] = useState<EFacility | null>(null);
  const [facilityDirectorName, setFacilityDirectorName] = useState<string>("");
  const [directorPhoneNumber, setDirectorPhoneNumber] = useState<string>("");
  const [facilityName, setFacilityName] = useState<string>("");
  const [facilityNumber, setFacilityNumber] = useState<string>("");
  const [facilityPostcode, setFacilityPostcode] = useState<string>("");
  const [facilityAddress, setFacilityAddress] = useState<string>("");
  const [facilityAddressDetail, setFacilityAddressDetail] = useState<string>("");
  const [facilityAddressExtra, setFacilityAddressExtra] = useState<string>("");
  const [facilityBusinessNumber, setFacilityBusinessNumber] = useState<string>("");
  const [certificationImg, setCertificationImg] = useState<File | null>(null);
  const [imgFileName, setImgFileName] = useState<string>("첨부파일");
  const [facilityContact, setFacilityContact] = useState<string>("");
  const [facilityHours, setFacilityHours] = useState<string>("");
  const [facilityFeatures, setFacilityFeatures] = useState<string>("");
  const [informationTakenWay, setInformationTakenWay] = useState<EInfoTake | undefined>(undefined);

  const [trigger, currentResult] = useRegisterMutation();
  const [triggerSecond, currentSecondResult] = useRegisterImageMutation();

  const navigate = useNavigate();

  const isFinished =
    facilityDirectorName.length > 0 &&
    directorPhoneNumber.length > 0 &&
    facilityName.length > 0 &&
    facilityNumber.length > 0 &&
    facilityPostcode.length > 0 &&
    facilityAddress.length > 0 &&
    facilityAddressDetail.length > 0 &&
    facilityBusinessNumber.length > 0 &&
    certificationImg !== null &&
    informationTakenWay !== undefined;

  const facilityAddressDetailRef = useRef<HTMLInputElement>(null);
  const certificationImgPreviewRef = useRef<HTMLImageElement>(null);

  const handleSearchPostCodeClick = () => {
    new window.daum.Postcode({
      oncomplete: function (data: any) {
        let addr = "";
        let extraAddr = "";

        if (data.userSelectedType === "R") {
          addr = data.roadAddress;
        } else {
          addr = data.jibunAddress;
        }

        if (data.userSelectedType === "R") {
          if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
            extraAddr += data.bname;
          }

          if (data.buildingName !== "" && data.apartment === "Y") {
            extraAddr += extraAddr !== "" ? ", " + data.buildingName : data.buildingName;
          }

          if (extraAddr !== "") {
            extraAddr = " (" + extraAddr + ")";
          }

          setFacilityAddressExtra(extraAddr);
        } else {
          setFacilityAddressExtra("");
        }

        setFacilityPostcode(data.zonecode);
        setFacilityAddress(addr);

        facilityAddressDetailRef.current?.focus();
      },
    }).open();
  };

  const handleCertImgChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const fileList = e.target.files;

    if (fileList && fileList[0]) {
      setCertificationImg(fileList[0]);

      const reader = new FileReader();
      reader.onload = (e: ProgressEvent<FileReader>) => {
        if (!certificationImgPreviewRef.current) {
          return;
        }

        certificationImgPreviewRef.current.src = e.target?.result as string;
        setImgFileName(fileList[0].name);
      };

      reader.readAsDataURL(fileList[0]);
    } else {
      if (!certificationImgPreviewRef.current) {
        return;
      }

      certificationImgPreviewRef.current.src = "";
      setImgFileName("첨부파일");
    }
  };

  const handleSubmit = () => {
    if (selected === null || informationTakenWay === undefined) {
      return;
    }

    trigger({
      medicalType: selected,
      directorName: facilityDirectorName,
      directorTel: directorPhoneNumber,
      medicalName: facilityName,
      medicalTel: facilityContact,
      zipCode: facilityPostcode,
      medicalAddress: facilityAddress,
      medicalDetailAddress: facilityAddressDetail,
      businessRegistrationNumber: facilityBusinessNumber,
      reciveType: informationTakenWay,
      medicalRuntime: facilityHours,
      medicalCharacteristics: facilityFeatures,
    });
  };

  useEffect(() => {
    const { isSuccess, isLoading } = currentResult;

    if (!isLoading && isSuccess) {
      if (certificationImg === null) {
        return;
      }

      const form = new FormData();
      form.append("file", certificationImg);

      triggerSecond({
        registerId: currentResult.data.registrationId,
        image: form,
      });
    }
  }, [certificationImg, currentResult, triggerSecond]);

  useEffect(() => {
    const { isSuccess, isLoading, isError } = currentSecondResult;

    if (isError) {
      navigate("/expert/registration/failure");
    }

    if (!isLoading && isSuccess) {
      navigate("/expert/registration/success");
    }
  }, [currentSecondResult, navigate]);

  return (
    <Outer>
      <Header>
        <BackButton to="/expert">
          <BackIcon />
          대시 보드로
        </BackButton>
        <ProgressBarWrapper>
          <ProgressBar className={selected !== null ? "on" : "off"} />
          <ProgressBar className={selected !== null && isFinished ? "on" : "off"} />
          <ProgressText>{selected === null ? "0 / 2" : isFinished ? "2 / 2" : "1 / 2"}</ProgressText>
        </ProgressBarWrapper>
      </Header>
      <InnerBox>
        <Title>기관 등록 페이지입니다.</Title>
        <Subtitle>
          1. 본인이 장으로 있는 요양 기관을 약 알에 등록하면 해당 기관의 전문가 분들이 본 서비스를 이용하실 수 있습니다.
          등록하려는 기관이 병원인지 약국인지 선택해주세요.
        </Subtitle>
        <SelectButtonWrapper>
          <SelectButtonBox
            className={selected === EFacility.HOSPITAL ? "selected" : "unselected"}
            onClick={() => setSelected(EFacility.HOSPITAL)}
          >
            <HospitalIcon />
            병원
          </SelectButtonBox>
          <SelectButtonBox
            className={selected === EFacility.PHARMACY ? "selected" : "unselected"}
            onClick={() => setSelected(EFacility.PHARMACY)}
          >
            <PharmacyIcon />
            약국
          </SelectButtonBox>
        </SelectButtonWrapper>
        {selected !== null && (
          <>
            <Subtitle>2. 전문가 인증에 필요한 정보를 입력해주세요.</Subtitle>
            <InputBox>
              <CertInputBox>
                <CertInputLabel>{selected === EFacility.HOSPITAL ? "병원장명*" : "약국장명*"}</CertInputLabel>
                <CertInput
                  type="text"
                  value={facilityDirectorName}
                  onChange={(e) => setFacilityDirectorName(e.currentTarget.value)}
                />
              </CertInputBox>
              <CertInputBox>
                <CertInputLabel>
                  {selected === EFacility.HOSPITAL ? "병원장 연락처(휴대폰)*" : "약국장 연락처(휴대폰)*"}
                </CertInputLabel>
                <CertInput
                  type="tel"
                  value={directorPhoneNumber}
                  onChange={(e) => setDirectorPhoneNumber(e.currentTarget.value)}
                />
              </CertInputBox>
              <CertInputBox>
                <CertInputLabel>
                  {selected === EFacility.HOSPITAL ? "병원명(요양기관명)*" : "약국명(요양기관명)*"}
                </CertInputLabel>
                <CertInput type="text" value={facilityName} onChange={(e) => setFacilityName(e.currentTarget.value)} />
              </CertInputBox>
              <CertInputBox>
                <CertInputLabel>요양기관번호*</CertInputLabel>
                <CertInput
                  type="text"
                  value={facilityNumber}
                  onChange={(e) => setFacilityNumber(e.currentTarget.value)}
                />
              </CertInputBox>
              <CertPostcodeInputBox>
                <CertInputBox>
                  <CertInputLabel>기관 우편번호*</CertInputLabel>
                  <PostcodeBox>
                    <CertInput
                      type="text"
                      value={facilityPostcode}
                      onChange={(e) => setFacilityPostcode(e.currentTarget.value)}
                    />
                    <PostcodeSearchButton onClick={handleSearchPostCodeClick}>우편번호 찾기</PostcodeSearchButton>
                  </PostcodeBox>
                </CertInputBox>
                <CertInputBox>
                  <CertInputLabel>{selected === EFacility.HOSPITAL ? "병원 주소*" : "약국 주소*"}</CertInputLabel>
                  <CertInput
                    type="text"
                    value={facilityAddress}
                    onChange={(e) => setFacilityAddress(e.currentTarget.value)}
                  />
                </CertInputBox>
                <CertAddressFooter>
                  <CertInputBox>
                    <CertInputLabel>상세 주소*</CertInputLabel>
                    <CertInput
                      type="text"
                      ref={facilityAddressDetailRef}
                      value={facilityAddressDetail}
                      onChange={(e) => setFacilityAddressDetail(e.currentTarget.value)}
                    />
                  </CertInputBox>
                  <CertInputBox>
                    <CertInputLabel>참고 항목</CertInputLabel>
                    <CertInput
                      type="text"
                      value={facilityAddressExtra}
                      onChange={(e) => setFacilityAddressExtra(e.currentTarget.value)}
                    />
                  </CertInputBox>
                </CertAddressFooter>
              </CertPostcodeInputBox>
              <CertInputBox>
                <CertInputLabel>사업자 번호*</CertInputLabel>
                <CertInput
                  type="text"
                  value={facilityBusinessNumber}
                  onChange={(e) => setFacilityBusinessNumber(e.currentTarget.value)}
                />
              </CertInputBox>
              <CertImgBox>
                <CertInputLabel>자격증 사진*</CertInputLabel>
                <CertInputImgBox>
                  <input readOnly={true} type="text" value={imgFileName} placeholder="첨부파일" />
                  <label htmlFor="file">파일찾기</label>
                  <input
                    type="file"
                    accept="image/jpg,impge/png,image/jpeg,image/gif"
                    id="file"
                    name="cerification_img"
                    onChange={handleCertImgChange}
                  />
                </CertInputImgBox>
                <CertImgPreview ref={certificationImgPreviewRef} />
              </CertImgBox>
              <CertInputBox>
                <CertInputLabel>
                  {selected === EFacility.HOSPITAL ? "병원 연락처(선택)" : "약국 연락처(선택)"}
                </CertInputLabel>
                <CertInput
                  type="text"
                  value={facilityContact}
                  onChange={(e) => setFacilityContact(e.currentTarget.value)}
                />
              </CertInputBox>
              <CertInputBox>
                <CertInputLabel>정보 수정 수신 방법*</CertInputLabel>
                <InfoTakeRadioBox>
                  <label>
                    <input
                      type="radio"
                      name="info-take"
                      value={informationTakenWay}
                      checked={informationTakenWay !== undefined ? informationTakenWay === EInfoTake.EMAIL : false}
                      onChange={() => setInformationTakenWay(EInfoTake.EMAIL)}
                    />
                    <span>이메일</span>
                  </label>
                  <label>
                    <input
                      type="radio"
                      name="info-take"
                      value={informationTakenWay}
                      checked={informationTakenWay !== undefined ? informationTakenWay === EInfoTake.PHONE : false}
                      onChange={() => setInformationTakenWay(EInfoTake.PHONE)}
                    />
                    <span>휴대폰</span>
                  </label>
                  <label>
                    <input
                      type="radio"
                      name="info-take"
                      value={informationTakenWay}
                      checked={informationTakenWay !== undefined ? informationTakenWay === EInfoTake.NONE : false}
                      onChange={() => setInformationTakenWay(EInfoTake.NONE)}
                    />
                    <span>받지 않음</span>
                  </label>
                </InfoTakeRadioBox>
              </CertInputBox>
              <CertInputBoxHours>
                <CertInputLabel>운영 시간(선택)</CertInputLabel>
                <CertInput
                  type="text"
                  value={facilityHours}
                  onChange={(e) => setFacilityHours(e.currentTarget.value)}
                />
              </CertInputBoxHours>
              <CertInputBoxFeatures>
                <CertInputLabel>
                  {selected === EFacility.HOSPITAL ? "병원 특징(선택)" : "약국 특징(선택)"}
                </CertInputLabel>
                <CertTextarea value={facilityFeatures} onChange={(e) => setFacilityFeatures(e.currentTarget.value)} />
              </CertInputBoxFeatures>
            </InputBox>
          </>
        )}
      </InnerBox>
      <NextButton
        className={selected !== null && isFinished ? "is-finished" : ""}
        disabled={!(selected !== null && isFinished)}
        onClick={handleSubmit}
      >
        다음
      </NextButton>
    </Outer>
  );
}
