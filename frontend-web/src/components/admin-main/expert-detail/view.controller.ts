import { AdminExpertDetailViewModel } from "@components/admin-main/expert-detail/view.model.ts";
import React, { useCallback, useEffect, useState } from "react";
import { usePathId } from "@hooks/use-path-id.ts";
import { denyExpert } from "@api/auth/admin.ts";
import { EJob } from "@type/enum/job.ts";

export const useAdminExpertDetailViewController = () => {
  AdminExpertDetailViewModel.use();

  const [approvalDialogOpen, setApprovalDialogOpen] = useState<boolean>(false);
  const [rejectionDialogOpen, setRejectionDialogOpen] = useState<boolean>(false);
  const [rejectionReason, setRejectionReason] = useState<string>("");

  const { getState, fetch } = AdminExpertDetailViewModel;
  const { expertDetail, isLoading } = getState();

  const expertId = usePathId();

  useEffect(() => {
    fetch(expertId);
  }, [expertId, fetch]);

  const openApprovalDialog = useCallback(() => {
    setApprovalDialogOpen(true);
  }, [setApprovalDialogOpen]);

  const openRejectionDialog = useCallback(() => {
    setRejectionDialogOpen(true);
  }, [setRejectionDialogOpen]);

  const onCloseApprovalDialog = useCallback(() => {
    setApprovalDialogOpen(false);
  }, [setApprovalDialogOpen]);

  const onCloseRejectionDialog = useCallback(() => {
    setRejectionDialogOpen(false);
    setRejectionReason("");
  }, [setRejectionDialogOpen]);

  const onClickOkayOnApprovalDialog = useCallback(() => {
    denyExpert(expertId, true, "", EJob.DOCTOR).finally(() => {
      setRejectionDialogOpen(false);
      setRejectionReason("");
    });
  }, [expertId]);

  const onClickOkayOnRejectionDialog = useCallback(() => {
    denyExpert(
      expertId,
      false,
      "",
      expertDetail!.belongInfo.type === "HOSPITAL" ? EJob.DOCTOR : EJob.PHARMACIST,
    ).finally(() => {
      setRejectionDialogOpen(false);
      setRejectionReason("");
    });
  }, [expertDetail, expertId]);

  const onChangeRejectionReason = useCallback(
    (event: React.ChangeEvent<HTMLTextAreaElement>) => {
      setRejectionReason(event.target.value);
    },
    [setRejectionReason],
  );

  return {
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
  };
};
