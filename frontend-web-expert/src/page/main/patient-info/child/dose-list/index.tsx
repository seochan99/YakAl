import Pagination from "react-js-pagination";
import {
  Bar,
  Header,
  CommonItem,
  ItemTitle,
  List,
  ListFooter,
  ListRow,
  PeriodSelectBox,
  PeriodSelectButton,
  RiskHeader,
  Title,
  TitleHeader,
  CommonBox,
  DateHeader,
  PeriodList,
  PeriodItem,
  PeriodItemButton,
  GreenIcon,
  YellowIcon,
  RedIcon,
  IconBox,
} from "./style";
import { useEffect, useRef, useState } from "react";

import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";
import { EPeriod } from "@/type/period";

type TDoseListProps = {
  patientId: number;
};

function DoseList({ patientId }: TDoseListProps) {
  const [page, setPage] = useState<number>(1);
  const [isOpen, setIsOpen] = useState<boolean>(false);
  const [selected, setSelected] = useState<string | null>(null);

  const periodListRef = useRef<HTMLUListElement>(null);

  useEffect(() => {
    const handleOutOfMenuClick = (e: MouseEvent) => {
      if (periodListRef.current) {
        if (!(e.target instanceof Node) || !periodListRef.current.contains(e.target)) {
          if (isOpen) {
            setTimeout(() => setIsOpen(false), 20);
          }
        }
      }
    };

    document.addEventListener("mouseup", handleOutOfMenuClick);

    return () => {
      document.removeEventListener("mouseup", handleOutOfMenuClick);
    };
  }, [isOpen]);

  const handlePageChange = (page: number) => {
    setPage(page);
    console.log(page);
  };

  const handleSelect = (e: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
    setSelected(e.currentTarget.value);
    setIsOpen(false);
  };

  const getRiskIcon = (polypharmacyRisk: number) => {
    switch (polypharmacyRisk) {
      case 0:
      case 1:
        return <GreenIcon />;
      case 2:
        return <YellowIcon />;
      case 3:
        return <RedIcon />;
      default:
        return null;
    }
  };

  const doseList = [
    { name: "네가박트정", polypharmacyRisk: 1, prescribed_at: new Date("2023-08-19") },
    { name: "가나릴정", polypharmacyRisk: 1, prescribed_at: new Date("2023-08-18") },
    { name: "아낙정", polypharmacyRisk: 0, prescribed_at: new Date("2023-08-17") },
    { name: "스토가정", polypharmacyRisk: 3, prescribed_at: new Date("2023-08-16") },
    { name: "알레그라정", polypharmacyRisk: 2, prescribed_at: new Date("2023-08-15") },
    {
      name: "동화디트로판정",
      polypharmacyRisk: 1,
      prescribed_at: new Date("2023-08-14"),
    },
  ];

  return (
    <>
      <Header>
        <Title>복약 목록</Title>
        <IconBox>
          <GreenIcon />
          {`${doseList.filter((dose) => dose.polypharmacyRisk === 0 || dose.polypharmacyRisk === 1).length}개`}
          <YellowIcon />
          {`${doseList.filter((dose) => dose.polypharmacyRisk === 2).length}개`}
          <RedIcon />
          {`${doseList.filter((dose) => dose.polypharmacyRisk === 3).length}개`}
        </IconBox>
        <PeriodSelectBox data-role="selectbox">
          <PeriodSelectButton className={isOpen ? "open" : ""} onClick={() => setIsOpen(!isOpen)}>
            <ArrowDropDownIcon />
            <span>{selected ? selected : "기간"}</span>
          </PeriodSelectButton>
          {isOpen && (
            <PeriodList ref={periodListRef}>
              {Object.keys(EPeriod).map((period) => {
                const value = EPeriod[period as keyof typeof EPeriod];
                return (
                  <PeriodItem key={period}>
                    <PeriodItemButton value={value} onClick={handleSelect}>
                      {value}
                    </PeriodItemButton>
                  </PeriodItem>
                );
              })}
            </PeriodList>
          )}
        </PeriodSelectBox>
      </Header>
      <Bar />
      <List>
        <ListRow>
          <TitleHeader>약품명</TitleHeader>
          <CommonBox>
            <RiskHeader>위험도</RiskHeader>
            <DateHeader>처방일</DateHeader>
          </CommonBox>
        </ListRow>
        {doseList.slice(5 * (page - 1), 5 * page).map((dose) => (
          <ListRow key={dose.name.concat("_" + dose.prescribed_at.toDateString())}>
            <ItemTitle>{dose.name.length > 9 ? dose.name.substring(0, 8).concat("...") : dose.name}</ItemTitle>
            <CommonBox>
              <CommonItem>{getRiskIcon(dose.polypharmacyRisk)}</CommonItem>
              <CommonItem>
                {`${dose.prescribed_at.getFullYear()}.
                ${
                  dose.prescribed_at.getMonth() + 1 < 10
                    ? "0".concat((dose.prescribed_at.getMonth() + 1).toString())
                    : dose.prescribed_at.getMonth() + 1
                }.
                ${dose.prescribed_at.getDate()}.`}
              </CommonItem>
            </CommonBox>
          </ListRow>
        ))}
      </List>
      <ListFooter>
        <Pagination
          activePage={page}
          itemsCountPerPage={5}
          totalItemsCount={doseList.length}
          pageRangeDisplayed={3}
          prevPageText={"‹"}
          nextPageText={"›"}
          onChange={handlePageChange}
        />
      </ListFooter>
    </>
  );
}

export default DoseList;
