function AdminExpertList() {
  // const [nameQueryCache, setNameQueryCache] = useState<string>("");
  // const [nameQuery, setNameQuery] = useState<string>("");
  // const [sortingOptionOpen, setSortingOptionOpen] = useState<boolean>(false);
  //
  // const selectListRef = useRef<HTMLUListElement>(null);
  //
  // const onSearchBarEnter = (event: React.KeyboardEvent<HTMLInputElement>) => {
  //   if (event.key === "Enter" && event.nativeEvent.isComposing === false) {
  //     setNameQuery(nameQueryCache);
  //   }
  // };
  //
  // const onSelectSortingOption = (e: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
  //   // setSortBy(EOrder.DESC, e.currentTarget.value as EPatientField);
  //   setSortingOptionOpen(false);
  // };
  //
  // return (
  //   <>
  //     <S.OptionBarDiv>
  //       <S.SearchBarDiv>
  //         <S.StyledSearchIconSvg />
  //         <S.SearchInput
  //           type="text"
  //           placeholder="전문가 이름으로 검색"
  //           value={nameQueryCache}
  //           onChange={(e) => setNameQueryCache(e.target.value)}
  //           onKeyUp={onSearchBarEnter}
  //         />
  //       </S.SearchBarDiv>
  //       <S.SelectDiv data-role="selectbox">
  //         <S.SelectButton
  //           className={sortingOptionOpen ? "open" : ""}
  //           onClick={() => setSortingOptionOpen(!sortingOptionOpen)}
  //         >
  //           <ArrowDropDownIcon />
  //           <span>{sorting.field}</span>
  //         </S.SelectButton>
  //         {sortingOptionOpen && (
  //           <S.SelectList ref={selectListRef}>
  //             {Object.keys(EFacilityField).map((patientFilter) => {
  //               const value = EPatientField[patientFilter as keyof typeof EPatientField];
  //               return (
  //                 <S.SelectItem key={patientFilter}>
  //                   <S.SelectItemButton value={value} onClick={onSelectSortingOption}>
  //                     {value}
  //                   </S.SelectItemButton>
  //                 </S.SelectItem>
  //               );
  //             })}
  //           </S.SelectList>
  //         )}
  //       </S.SelectDiv>
  //     </S.OptionBarDiv>
  //   </>
  // );
  return <></>;
}

export default AdminExpertList;
