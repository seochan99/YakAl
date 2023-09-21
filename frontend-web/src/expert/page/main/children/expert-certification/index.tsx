import { ListFooter } from "../../../../style.ts";
import {
  AddressHeader,
  BackButton,
  BackIcon,
  BelongInput,
  BelongInputBox,
  BelongInputBoxWrapper,
  CertBelongExplanation,
  CertBelongImgPreview,
  CertDoctorImgExample,
  CertExampleBox,
  CertExampleText,
  CertHeader,
  CertImgBox,
  CertImgPreview,
  CertImgPreviewBox,
  CertImgPreviewWrapper,
  CertInputImgBox,
  CertInputLabel,
  CertPharmacistEmgExample,
  DoctorIcon,
  Emphasis,
  InnerBox,
  Item,
  ItemAddress,
  ItemName,
  ListHeader,
  NameHeader,
  NextButton,
  Outer,
  PharmacistIcon,
  ProgressBar,
  ProgressBarWrapper,
  ProgressText,
  SearchBar,
  SearchButton,
  SearchInput,
  SearchResultBox,
  SelectButtonBox,
  SelectButtonWrapper,
  Subtitle,
  Title,
} from "./style.ts";
import React, { useRef, useState } from "react";
import Pagination from "react-js-pagination";
import { EJob } from "../../../../type/job.ts";
import { useNavigate } from "react-router-dom";
import { facilityList } from "../../../../store/facility-list.ts";
import { TFacility } from "../../../../../admin/page/main/facility-registration-list";

const PAGING_SIZE = 5;

function ExpertCertification() {
  const [selected, setSelected] = useState<EJob | null>(null);
  const [certificationImg, setCertificationImg] = useState<File | null>(null);
  const [certImgFileName, setCertImgFileName] = useState<string>("첨부파일");
  const [belongImg, setBelongImg] = useState<File | null>(null);
  const [belongImgFileName, setBelongImgFileName] = useState<string>("첨부파일");
  const [page, setPage] = useState<number>(1);
  const [selectedFacility, setSelectedFacility] = useState<TFacility | null>(null);
  const [facilityNameSearchQuery, setFacilityNameSearchQuery] = useState<string>("");

  const navigate = useNavigate();

  const certificationImgPreviewRef = useRef<HTMLImageElement>(null);
  const belongImgPreviewRef = useRef<HTMLImageElement>(null);

  const isFinished = selectedFacility !== null && certificationImg !== null && belongImg !== null;

  const handlePageChange = (page: number) => {
    setPage(page);
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
        setCertImgFileName(fileList[0].name);
      };

      reader.readAsDataURL(fileList[0]);
    } else {
      if (!certificationImgPreviewRef.current) {
        return;
      }

      certificationImgPreviewRef.current.src = "";
      setCertImgFileName("첨부파일");
    }
  };

  const handleBelongImgChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const fileList = e.target.files;

    if (fileList && fileList[0]) {
      setBelongImg(fileList[0]);

      const reader = new FileReader();
      reader.onload = (e: ProgressEvent<FileReader>) => {
        if (!belongImgPreviewRef.current) {
          return;
        }

        belongImgPreviewRef.current.src = e.target?.result as string;
        setBelongImgFileName(fileList[0].name);
      };

      reader.readAsDataURL(fileList[0]);
    } else {
      if (!belongImgPreviewRef.current) {
        return;
      }

      belongImgPreviewRef.current.src = "";
      setBelongImgFileName("첨부파일");
    }
  };

  const handleFacilityItemClick = (id: number) => () => {
    const selectedItem = facilityList.findLast((facility) => facility.id === id);

    if (selectedItem) {
      setSelectedFacility(selectedItem);
    }
  };

  const handleSubmit = () => {
    navigate("/expert/certification/success");
  };

  return (
    <Outer>
      <CertHeader>
        <BackButton to="/expert">
          <BackIcon />
          대시 보드로
        </BackButton>
        <ProgressBarWrapper>
          <ProgressBar className={selected !== null ? "on" : "off"} />
          <ProgressBar className={selected !== null && isFinished ? "on" : "off"} />
          <ProgressText>{selected !== null ? (isFinished ? "2 / 2" : "1 / 2") : "0 / 2"}</ProgressText>
        </ProgressBarWrapper>
      </CertHeader>
      <InnerBox>
        <Title>전문가 인증 페이지입니다.</Title>
        <Subtitle>
          1. 전문가 인증을 완료해야 본 서비스를 이용하실 수 있습니다. 아래에서 본인에게 해당되는 직군을 선탹해주세요.
        </Subtitle>
        <SelectButtonWrapper>
          <SelectButtonBox
            className={selected === EJob.DOCTOR ? "selected" : "unselected"}
            onClick={() => {
              setSelected(EJob.DOCTOR);
              setSelectedFacility(null);
            }}
          >
            <DoctorIcon />
            의사입니다.
          </SelectButtonBox>
          <SelectButtonBox
            className={selected === EJob.PHARMACIST ? "selected" : "unselected"}
            onClick={() => {
              setSelected(EJob.PHARMACIST);
              setSelectedFacility(null);
            }}
          >
            <PharmacistIcon />
            약사입니다.
          </SelectButtonBox>
        </SelectButtonWrapper>
        {selected !== null && (
          <>
            <Subtitle>2. 전문가 인증에 필요한 정보를 입력해주세요.</Subtitle>
            <BelongInputBoxWrapper>
              <CertInputLabel>소속 기관*</CertInputLabel>
              <BelongInputBox>
                <BelongInput
                  type={"text"}
                  name={"facility-name"}
                  placeholder={"기관명"}
                  readOnly={true}
                  value={selectedFacility ? selectedFacility.name : ""}
                />
                <BelongInput
                  type={"text"}
                  name={"facility-address"}
                  placeholder={"기관 주소"}
                  readOnly={true}
                  value={selectedFacility ? selectedFacility.directorName : ""}
                />
              </BelongInputBox>
              <SearchBar>
                <SearchButton />
                <SearchInput
                  type="text"
                  placeholder="기관명으로 검색"
                  value={facilityNameSearchQuery}
                  onChange={(e) => setFacilityNameSearchQuery(e.target.value)}
                />
              </SearchBar>
              <SearchResultBox>
                <ListHeader>
                  <NameHeader>기관명</NameHeader>
                  <AddressHeader>기관 주소</AddressHeader>
                </ListHeader>
                {facilityList.map((facility) => (
                  <Item key={facility.name} onClick={handleFacilityItemClick(facility.id)}>
                    <ItemName>
                      {facility.name.length > 21 ? facility.name.substring(0, 20).concat("...") : facility.name}
                    </ItemName>
                    <ItemAddress>
                      {facility.directorName.length > 41
                        ? facility.directorName.substring(0, 40).concat("...")
                        : facility.directorName}
                    </ItemAddress>
                  </Item>
                ))}
              </SearchResultBox>
              <ListFooter>
                <Pagination
                  activePage={page}
                  itemsCountPerPage={PAGING_SIZE}
                  totalItemsCount={facilityList.length}
                  pageRangeDisplayed={PAGING_SIZE}
                  prevPageText={"‹"}
                  nextPageText={"›"}
                  onChange={handlePageChange}
                />
              </ListFooter>
            </BelongInputBoxWrapper>
            <CertImgBox>
              <CertInputLabel>자격증 사진*</CertInputLabel>
              <CertInputImgBox>
                <input readOnly={true} type="text" value={certImgFileName} placeholder="첨부파일" />
                <label htmlFor="cert">파일찾기</label>
                <input
                  type="file"
                  accept="image/jpg,impge/png,image/jpeg,image/gif"
                  id="cert"
                  name="cerification_img"
                  onChange={handleCertImgChange}
                />
              </CertInputImgBox>
              <CertImgPreviewBox>
                <CertExampleBox>
                  {selected === EJob.DOCTOR ? <CertDoctorImgExample /> : <CertPharmacistEmgExample />}
                  <CertExampleText>
                    {selected === EJob.DOCTOR
                      ? "* 전문의 자격증을 성명과 주민등록번호가 잘 드러나도록 찍어서 제출해주세요."
                      : "* 약사 면허증을 성명, 생년월일이 잘 드러나도록 찍어서 제출해주세요."}
                  </CertExampleText>
                </CertExampleBox>
                <CertImgPreviewWrapper>
                  <CertImgPreview ref={certificationImgPreviewRef} />
                </CertImgPreviewWrapper>
              </CertImgPreviewBox>
            </CertImgBox>
            <CertImgBox>
              <CertInputLabel>{"소속 증명 사진*"}</CertInputLabel>
              <CertBelongExplanation>
                {"소속 증명 사진이라 함은 소속 기관이 기재되어 있는 명함 등 "}
                <Emphasis>{"해당 기관에 재직 중임을 확인할 수 있는 사진"}</Emphasis>
                {
                  "입니다. (예: 대학병원라면 내과 000 전문의 이름 적혀있는 사진, 개인병원이라면 해당 병원에 있는 의사 팻말 등)"
                }
              </CertBelongExplanation>
              <CertInputImgBox>
                <input readOnly={true} type="text" value={belongImgFileName} placeholder="첨부파일" />
                <label htmlFor="belong">파일찾기</label>
                <input
                  type="file"
                  accept="image/jpg,impge/png,image/jpeg,image/gif"
                  id="belong"
                  name="belong_img"
                  onChange={handleBelongImgChange}
                />
              </CertInputImgBox>
              <CertBelongImgPreview ref={belongImgPreviewRef} />
            </CertImgBox>
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

export default ExpertCertification;
