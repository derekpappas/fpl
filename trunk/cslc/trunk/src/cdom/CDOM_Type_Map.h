#ifndef _INC_GUARD_CDOM_TYPE_MAP_H
#define _INC_GUARD_CDOM_TYPE_MAP_H

#include <string>
#include "CDOM.h"
#include <map>

namespace NSCdom {

typedef std::map<ECDOmType, std::string> TMap_ECDOmType_String;

class ECDOmType_to_String {
private:
  TMap_ECDOmType_String m_ecdom_int;
public:
  void createTypeMap( void){
    m_ecdom_int[TYPE_ALL_TYPES                 ] = "TYPE_ALL_TYPES                 ";
    m_ecdom_int[TYPE_ALL_TOP_LEVELS            ] = "TYPE_ALL_TOP_LEVELS            ";
    m_ecdom_int[TYPE_ALL_SCOPE_HOLDERS         ] = "TYPE_ALL_SCOPE_HOLDERS         ";
    m_ecdom_int[TYPE_ALL_STMTS                 ] = "TYPE_ALL_STMTS                 ";
    m_ecdom_int[TYPE_ALL_FUNC_STMTS            ] = "TYPE_ALL_FUNC_STMTS            ";
    m_ecdom_int[TYPE_ALL_MODULE_ITEMS          ] = "TYPE_ALL_MODULE_ITEMS          ";
    m_ecdom_int[TYPE_ALL_BLOCK_ITEMS           ] = "TYPE_ALL_BLOCK_ITEMS           ";
    m_ecdom_int[TYPE_ALL_TASK_ITEMS            ] = "TYPE_ALL_TASK_ITEMS            ";
    m_ecdom_int[TYPE_ALL_FUNC_ITEMS            ] = "TYPE_ALL_FUNC_ITEMS            ";
    m_ecdom_int[TYPE_ALL_GEN_ITEMS             ] = "TYPE_ALL_GEN_ITEMS             ";
    m_ecdom_int[TYPE_DESIGN                    ] = "TYPE_DESIGN                    ";
    m_ecdom_int[TYPE_ID_SIMPLE                 ] = "TYPE_ID_SIMPLE                 ";
    m_ecdom_int[TYPE_ID_SCOPE_DIRECT           ] = "TYPE_ID_SCOPE_DIRECT           ";
    m_ecdom_int[TYPE_ID_SCOPE_INDIRECT         ] = "TYPE_ID_SCOPE_INDIRECT         ";
    m_ecdom_int[TYPE_PORT_ITEM                 ] = "TYPE_PORT_ITEM                 ";
    m_ecdom_int[TYPE_DECL_MODULE               ] = "TYPE_DECL_MODULE               ";
    m_ecdom_int[TYPE_DECL_TASK                 ] = "TYPE_DECL_TASK                 ";
    m_ecdom_int[TYPE_DECL_FUNCTION             ] = "TYPE_DECL_FUNCTION             ";
    m_ecdom_int[TYPE_SPEC_BLOCK                ] = "TYPE_SPEC_BLOCK                ";
    m_ecdom_int[TYPE_DECL_UDP                  ] = "TYPE_DECL_UDP                  ";
    m_ecdom_int[TYPE_EXPR                      ] = "TYPE_EXPR                      ";
    m_ecdom_int[TYPE_LIST_EXPR                 ] = "TYPE_LIST_EXPR                 ";
    m_ecdom_int[TYPE_HID_ITEMS                 ] = "TYPE_HID_ITEMS                 ";
    m_ecdom_int[TYPE_ATTR_LIST                 ] = "TYPE_ATTR_LIST                 ";
    m_ecdom_int[TYPE_ATTR_LIST_COLLECTION      ] = "TYPE_ATTR_LIST_COLLECTION      ";
    m_ecdom_int[TYPE_STMT                      ] = "TYPE_STMT                      ";
    m_ecdom_int[TYPE_STMT_NAMED_BLOCK          ] = "TYPE_STMT_NAMED_BLOCK          ";
    m_ecdom_int[TYPE_DELAY_CONTROL             ] = "TYPE_DELAY_CONTROL             ";
    m_ecdom_int[TYPE_EVENT_CONTROL             ] = "TYPE_EVENT_CONTROL             ";
    m_ecdom_int[TYPE_EVENT_EXPR                ] = "TYPE_EVENT_EXPR                ";
    m_ecdom_int[TYPE_RANGE                     ] = "TYPE_RANGE                     ";
    m_ecdom_int[TYPE_ASSN                      ] = "TYPE_ASSN                      ";
    m_ecdom_int[TYPE_RANGE_LIST                ] = "TYPE_RANGE_LIST                ";
    m_ecdom_int[TYPE_RANGE_EXPR                ] = "TYPE_RANGE_EXPR                ";
    m_ecdom_int[TYPE_PARAM_DECL                ] = "TYPE_PARAM_DECL                ";
    m_ecdom_int[TYPE_PARAM_DECL_COLLECTION     ] = "TYPE_PARAM_DECL_COLLECTION     ";
    m_ecdom_int[TYPE_PORT_DECL                 ] = "TYPE_PORT_DECL                 ";
    m_ecdom_int[TYPE_UDP_PORT_DECL_INPUT       ] = "TYPE_UDP_PORT_DECL_INPUT       ";
    m_ecdom_int[TYPE_UDP_PORT_DECL_OUTPUT      ] = "TYPE_UDP_PORT_DECL_OUTPUT      ";
    m_ecdom_int[TYPE_UDP_INIT_STMT             ] = "TYPE_UDP_INIT_STMT             ";
    m_ecdom_int[TYPE_UDP_COMB_ENTRY            ] = "TYPE_UDP_COMB_ENTRY            ";
    m_ecdom_int[TYPE_UDP_SEQ_ENTRY             ] = "TYPE_UDP_SEQ_ENTRY             ";
    m_ecdom_int[TYPE_TF_PORT_DECL              ] = "TYPE_TF_PORT_DECL              ";
    m_ecdom_int[TYPE_VAR_DECL                  ] = "TYPE_VAR_DECL                  ";
    m_ecdom_int[TYPE_DELAY                     ] = "TYPE_DELAY                     ";
    m_ecdom_int[TYPE_NET_DECL                  ] = "TYPE_NET_DECL                  ";
    m_ecdom_int[TYPE_PULSE_CONTROL             ] = "TYPE_PULSE_CONTROL             ";
    m_ecdom_int[TYPE_EVENT_DECL                ] = "TYPE_EVENT_DECL                ";
    m_ecdom_int[TYPE_GENVAR_DECL               ] = "TYPE_GENVAR_DECL               ";
    m_ecdom_int[TYPE_GEN_INST                  ] = "TYPE_GEN_INST                  ";
    m_ecdom_int[TYPE_GEN_ITEM_NULL             ] = "TYPE_GEN_ITEM_NULL             ";
    m_ecdom_int[TYPE_GEN_ITEM_IF               ] = "TYPE_GEN_ITEM_IF               ";
    m_ecdom_int[TYPE_GEN_ITEM_CASE             ] = "TYPE_GEN_ITEM_CASE             ";
    m_ecdom_int[TYPE_GEN_ITEM_LOOP             ] = "TYPE_GEN_ITEM_LOOP             ";
    m_ecdom_int[TYPE_GEN_ITEM_BLOCK_NAMED      ] = "TYPE_GEN_ITEM_BLOCK_NAMED      ";
    m_ecdom_int[TYPE_GEN_ITEM_BLOCK_UNNAMED    ] = "TYPE_GEN_ITEM_BLOCK_UNNAMED    ";
    m_ecdom_int[TYPE_PARAM_OVERRIDE            ] = "TYPE_PARAM_OVERRIDE            ";
    m_ecdom_int[TYPE_CONT_ASSN                 ] = "TYPE_CONT_ASSN                 ";
    m_ecdom_int[TYPE_INST_GATE                 ] = "TYPE_INST_GATE                 ";
    m_ecdom_int[TYPE_INST_UDP                  ] = "TYPE_INST_UDP                  ";
    m_ecdom_int[TYPE_INST_MODULE               ] = "TYPE_INST_MODULE               ";
    m_ecdom_int[TYPE_MODULE_INSTANTIATION      ] = "TYPE_MODULE_INSTANTIATION      ";
    m_ecdom_int[TYPE_INITIAL_OR_ALWAYS         ] = "TYPE_INITIAL_OR_ALWAYS         ";
    m_ecdom_int[TYPE_PULSESTYLE_SHOWCANCELLED  ] = "TYPE_PULSESTYLE_SHOWCANCELLED  ";
    m_ecdom_int[TYPE_SPEC_TERM_LIST            ] = "TYPE_SPEC_TERM_LIST            ";
    m_ecdom_int[TYPE_MINTYPMAX_LIST            ] = "TYPE_MINTYPMAX_LIST            ";
    m_ecdom_int[TYPE_PATH_DELAY_VALUE          ] = "TYPE_PATH_DELAY_VALUE          ";
    m_ecdom_int[TYPE_SYSTEM_TIMING_CHECK       ] = "TYPE_SYSTEM_TIMING_CHECK       ";
    m_ecdom_int[TYPE_DELAYED_DATA_OR_REFERENCE ] = "TYPE_DELAYED_DATA_OR_REFERENCE ";
    m_ecdom_int[TYPE_TIMING_CHECK_EVENT_CONTROL] = "TYPE_TIMING_CHECK_EVENT_CONTROL";
    m_ecdom_int[TYPE_TIMING_CHECK_EVENT        ] = "TYPE_TIMING_CHECK_EVENT        ";
    m_ecdom_int[TYPE_PATH_DECL                 ] = "TYPE_PATH_DECL                 ";
    m_ecdom_int[TYPE_PRIMITIVE_INSTANCE        ] = "TYPE_PRIMITIVE_INSTANCE        ";
    m_ecdom_int[TYPE_GATE_INSTANTIATION        ] = "TYPE_GATE_INSTANTIATION        ";
  }
  std::string getStringType(ECDOmType type) {
    return m_ecdom_int[type];
  }
};

}
#endif
