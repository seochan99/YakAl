import React, { useEffect, useRef, useState } from "react";
import { EOrder } from "@type/order.ts";
import { AdminExpertListViewModel } from "@components/admin-main/expert-list/view.model.ts";
import { EExpertField } from "@type/expert-field.ts";

export const useAdminExpertListViewController = () => {
  AdminExpertListViewModel.use();

  const { fetch, getStates, setPageNumber, setSortBy, setNameQuery } = AdminExpertListViewModel;
  const { isLoading, expertList, paging, sorting, nameQuery } = getStates();

  const [sortingOptionOpen, setSortingOptionOpen] = useState<boolean>(false);
  const [nameQueryCache, setNameQueryCache] = useState<string>("");

  const selectListRef = useRef<HTMLUListElement>(null);

  useEffect(() => {
    fetch();
  }, [fetch]);

  useEffect(() => {
    const handleOutOfMenuClick = (e: MouseEvent) => {
      if (selectListRef.current) {
        if (!(e.target instanceof Node) || !selectListRef.current.contains(e.target)) {
          if (sortingOptionOpen) {
            setTimeout(() => setSortingOptionOpen(false), 20);
          }
        }
      }
    };

    document.addEventListener("mouseup", handleOutOfMenuClick);

    return () => {
      document.removeEventListener("mouseup", handleOutOfMenuClick);
    };
  }, [sortingOptionOpen, setSortingOptionOpen]);

  const onSelectSortingOption = (e: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
    setSortingOptionOpen(false);

    const currentField = e.currentTarget.value as EExpertField;
    if (sorting.field === currentField) {
      if (sorting.order === EOrder.DESC) {
        setSortBy(EOrder.ASC, currentField);
      } else {
        setSortBy(EOrder.DESC, currentField);
      }
    } else {
      if (currentField === EExpertField.NAME || currentField === EExpertField.BELONG_NAME) {
        setSortBy(EOrder.ASC, currentField);
      } else {
        setSortBy(EOrder.DESC, currentField);
      }
    }
  };

  const onChangePage = (pageNumber: number) => {
    if (pageNumber === paging.pageNumber) {
      return;
    }

    setPageNumber(pageNumber);
  };

  const onSearchBarEnter = (event: React.KeyboardEvent<HTMLInputElement>) => {
    if (event.key === "Enter" && event.nativeEvent.isComposing === false) {
      if (nameQuery === nameQueryCache) {
        return;
      }

      setNameQuery(nameQueryCache);
    }
  };

  return {
    selectListRef,
    onChangePage,
    searching: { nameQueryCache, setNameQueryCache, onSearchBarEnter },
    sorting: { onSelectSortingOption, sortingOptionOpen, setSortingOptionOpen },
    data: { isLoading, expertList, paging, sorting },
  };
};
