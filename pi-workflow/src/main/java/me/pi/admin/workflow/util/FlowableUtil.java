/*
 * Copyright 2022-2023 ZnPi
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package me.pi.admin.workflow.util;

import org.flowable.bpmn.converter.BpmnXMLConverter;
import org.flowable.bpmn.model.*;
import org.flowable.bpmn.model.Process;
import org.flowable.common.engine.impl.util.io.StringStreamSource;

import java.util.*;

/**
 * @author ZnPi
 * @date 2023-04-07
 */
public final class FlowableUtil {
    private FlowableUtil() {
    }

    private static final BpmnXMLConverter BPMN_XML_CONVERTER = new BpmnXMLConverter();

    /**
     * 根据 BpmnXML 获取 BpmnModel
     *
     * @param bpmnXml BpmnXML
     * @return BpmnModel
     */
    public static BpmnModel getBpmnModel(String bpmnXml) {
        return BPMN_XML_CONVERTER.convertToBpmnModel(new StringStreamSource(bpmnXml),
                false, false);
    }

    /**
     * 获取流程元素信息
     *
     * @param bpmnModel     BpmnModel
     * @param flowElementId 元素 ID
     * @return 元素信息
     */
    public static FlowElement getFlowElementById(BpmnModel bpmnModel, String flowElementId) {
        Process process = bpmnModel.getMainProcess();
        return process.getFlowElement(flowElementId);
    }

    /**
     * 获取元素表单
     *
     * @param flowElement 元素
     * @return 表单
     */
    public static String getFormKey(FlowElement flowElement) {
        if (flowElement != null) {
            if (flowElement instanceof StartEvent) {
                return ((StartEvent) flowElement).getFormKey();
            } else if (flowElement instanceof UserTask) {
                return ((UserTask) flowElement).getFormKey();
            }
        }
        return null;
    }

    /**
     * 获取全部流程元素，包含子流程元素
     *
     * @param flowElements 流程元素
     * @param allElements  包含子流程元素的流程元素
     */
    public static void getAllElements(Collection<FlowElement> flowElements,
                                      Collection<FlowElement> allElements) {
        for (FlowElement flowElement : flowElements) {
            allElements.add(flowElement);
            if (flowElement instanceof SubProcess) {
                getAllElements(((SubProcess) flowElement).getFlowElements(), allElements);
            }
        }
    }

    /**
     * 获取父元素列表
     *
     * @param target 目标元素
     * @return 父元素列表
     */
    public static List<String> getParentElements(FlowElement target) {
        return doGetParentElements(target, null);
    }

    /**
     * 获取父元素列表
     *
     * @param target                  目标元素
     * @param finishedSequenceFlowIds 已经经过的序列流 ID，用于判断序列流连线是否重复
     * @return 父元素列表
     */
    private static List<String> doGetParentElements(FlowElement target, List<String> finishedSequenceFlowIds) {
        finishedSequenceFlowIds = finishedSequenceFlowIds == null ? new ArrayList<>() : finishedSequenceFlowIds;

        // 获取入口连线
        List<SequenceFlow> sequenceFlows = getIncomingFlows(target);

        if (sequenceFlows != null) {
            // 循环找到目标元素
            for (SequenceFlow sequenceFlow : sequenceFlows) {
                // 连线重复
                if (finishedSequenceFlowIds.contains(sequenceFlow.getId())) {
                    continue;
                }
                // 已经经过的序列流
                finishedSequenceFlowIds.add(sequenceFlow.getId());
                FlowElement finishedElement = sequenceFlow.getSourceFlowElement();
                // 子流程
                if (finishedElement instanceof SubProcess) {
                    // 子流程的开始开始事件元素
                    FlowElement firstElement = (StartEvent) ((SubProcess) finishedElement).getFlowElements().toArray()[0];
                    // 获取子流程的父元素
                    finishedSequenceFlowIds.addAll(doGetParentElements(firstElement, null));
                }
                finishedSequenceFlowIds = doGetParentElements(finishedElement, finishedSequenceFlowIds);
            }
        }
        return finishedSequenceFlowIds;
    }

    /**
     * 获取指定元素的入口连线
     *
     * @param target 目标元素
     * @return 指定元素的入口连线
     */
    public static List<SequenceFlow> getIncomingFlows(FlowElement target) {
        List<SequenceFlow> sequenceFlows = null;
        if (target instanceof FlowNode) {
            sequenceFlows = ((FlowNode) target).getIncomingFlows();
        }
        return sequenceFlows;
    }

    /**
     * 获取指定元素的出口连线
     *
     * @param target 目标元素
     * @return 指定元素的出口连线
     */
    public static List<SequenceFlow> getOutgoingFlows(FlowElement target) {
        List<SequenceFlow> sequenceFlows = null;
        if (target instanceof FlowNode) {
            sequenceFlows = ((FlowNode) target).getOutgoingFlows();
        }
        return sequenceFlows;
    }

    /**
     * 获取开始节点
     *
     * @param model BpmnModel
     * @return 开始节点
     */
    public static StartEvent getStartEvent(BpmnModel model) {
        Process process = model.getMainProcess();
        FlowElement startElement = process.getInitialFlowElement();
        if (startElement instanceof StartEvent) {
            return (StartEvent) startElement;
        }
        return getStartEvent(process.getFlowElements());
    }

    /**
     * 获取开始节点
     *
     * @param flowElements Collection<FlowElement>
     * @return 开始节点
     */
    public static StartEvent getStartEvent(Collection<FlowElement> flowElements) {
        for (FlowElement flowElement : flowElements) {
            if (flowElement instanceof StartEvent) {
                return (StartEvent) flowElement;
            }
        }
        return null;
    }

    /**
     * 获取结束节点
     *
     * @param bpmnModel BPMN Model
     * @return 结束节点
     */
    public static EndEvent getEndEvent(BpmnModel bpmnModel) {
        Process process = bpmnModel.getMainProcess();
        return getEndEvent(process.getFlowElements());
    }

    /**
     * 获取结束节点
     *
     * @param flowElements Collection<FlowElement>
     * @return 结束节点
     */
    public static EndEvent getEndEvent(Collection<FlowElement> flowElements) {
        for (FlowElement flowElement : flowElements) {
            if (flowElement instanceof EndEvent) {
                return (EndEvent) flowElement;
            }
        }
        return null;
    }

    public static UserTask getUserTaskByKey(BpmnModel bpmnModel, String taskDefinitionKey) {
        Process process = bpmnModel.getMainProcess();
        FlowElement flowElement = process.getFlowElement(taskDefinitionKey);
        if (flowElement instanceof UserTask) {
            return (UserTask) flowElement;
        }
        return null;
    }

    public static List<UserTask> getNextUserTasks(UserTask userTask) {
        return getNextUserTasks(userTask, null, null);
    }

    public static List<UserTask> getNextUserTasks(FlowElement source, Set<String> hasSequenceFlow, List<UserTask> userTaskList) {
        hasSequenceFlow = Optional.ofNullable(hasSequenceFlow).orElse(new HashSet<>());
        userTaskList = Optional.ofNullable(userTaskList).orElse(new ArrayList<>());
        List<SequenceFlow> sequenceFlows = getOutgoingFlows(source);
        if (!sequenceFlows.isEmpty()) {
            for (SequenceFlow sequenceFlow : sequenceFlows) {
                if (hasSequenceFlow.contains(sequenceFlow.getId())) {
                    continue;
                }
                hasSequenceFlow.add(sequenceFlow.getId());
                FlowElement targetFlowElement = sequenceFlow.getTargetFlowElement();
                if (targetFlowElement instanceof UserTask) {
                    userTaskList.add((UserTask) targetFlowElement);
                } else {
                    getNextUserTasks(targetFlowElement, hasSequenceFlow, userTaskList);
                }
            }
        }
        return userTaskList;
    }
}
