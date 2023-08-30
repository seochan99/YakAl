import Pagination from "react-js-pagination";
import {
  Bar,
  Header,
  ItemDate,
  ItemTitle,
  List,
  ListHeader,
  PeriodSelectBox,
  PeriodSelectButton,
  RiskHeader,
  Title,
  TitleHeader,
  DateHeader,
  PeriodList,
  PeriodItem,
  PeriodItemButton,
  GreenIcon,
  YellowIcon,
  RedIcon,
  Item,
  ItemIcon,
} from "./style.ts";
import { useEffect, useRef, useState } from "react";

import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";
import { EPeriod } from "@/expert/type/period.ts";
import { ListFooter } from "@/expert/style.ts";

// type TDoseListProps = {
//   patientId: number;
// };

// function DoseList({ patientId }: TDoseListProps) {
function DoseList() {
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
        <ListHeader>
          <TitleHeader>약품명</TitleHeader>
          <RiskHeader>위험도</RiskHeader>
          <DateHeader>처방일</DateHeader>
        </ListHeader>
        {doseList.slice(5 * (page - 1), 5 * page).map((dose) => (
          <Item key={dose.name.concat("_" + dose.prescribed_at.toDateString())}>
            <ItemTitle>{dose.name.length > 9 ? dose.name.substring(0, 8).concat("...") : dose.name}</ItemTitle>
            <ItemIcon>{getRiskIcon(dose.polypharmacyRisk)}</ItemIcon>
            <ItemDate>
              {`${dose.prescribed_at.getFullYear()}.
                ${
                  dose.prescribed_at.getMonth() + 1 < 10
                    ? "0".concat((dose.prescribed_at.getMonth() + 1).toString())
                    : dose.prescribed_at.getMonth() + 1
                }.
                ${dose.prescribed_at.getDate()}.`}
            </ItemDate>
          </Item>
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
