package com.bigtreetc.sample.batch.jobs.sendmail;

import com.bigtreetc.sample.batch.context.BatchContext;
import com.bigtreetc.sample.batch.jobs.BaseItemWriter;
import com.bigtreetc.sample.common.util.ListUtils;
import com.bigtreetc.sample.domain.dao.SendMailQueueDao;
import com.bigtreetc.sample.domain.entity.SendMailQueue;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;

@Slf4j
public class SendMailQueueItemWriter extends BaseItemWriter<SendMailQueue> {

  @Autowired SendMailQueueDao sendMailQueueDao;

  @Override
  protected void doWrite(BatchContext context, List<SendMailQueue> items) {
    if (log.isDebugEnabled()) {
      log.debug("{} items to write.", ListUtils.size(items));
    }

    sendMailQueueDao.update(items);
  }
}
