/**
 * Java harness toward legacy TB drivers under {@code trunk/cslc/trunk/csl_gen/} ({@code cGenDecl_tb.*},
 * {@code cGenCmds_tb.*}, {@code cGenInstDecl_tb.*}, {@code cGenInstCmds_tb.*}) and shared {@code cGenBase_tb.*} /
 * {@code cGen_Consts.h} pieces. {@code cGen_Support.h} is only an include stack for C++; here we depend on
 * {@link com.fastpath.cslc.cslgen.CGenConsts} for names like {@link com.fastpath.cslc.cslgen.CGenConsts#ENV_VAR_NAME}.
 *
 * <p><b>Types:</b> {@link com.fastpath.cslc.cslgen.cgentb.CGenTbEslClass} / {@link com.fastpath.cslc.cslgen.cgentb.CGenTbCmdType}
 * (regen scripts under {@code cslc-java/scripts/}), {@link com.fastpath.cslc.cslgen.cgentb.CGenTbClassRef}, {@link
 * com.fastpath.cslc.cslgen.cgentb.CGenTbCmdRef}, {@link com.fastpath.cslc.cslgen.cgentb.CGenDeclTb}, {@link
 * com.fastpath.cslc.cslgen.cgentb.CGenCmdTb}, {@link com.fastpath.cslc.cslgen.cgentb.CGenInstDeclTb}, {@link
 * com.fastpath.cslc.cslgen.cgentb.CGenInstCmdTb}, {@link com.fastpath.cslc.cslgen.cgentb.CGenTbMainArgs}, {@link
 * com.fastpath.cslc.cslgen.cgentb.CGenTbRepositoryPath}, {@link com.fastpath.cslc.cslgen.cgentb.CGenTbChapterDirs}, {@link
 * com.fastpath.cslc.cslgen.cgentb.CGenTbBuildContainers}, {@link com.fastpath.cslc.cslgen.cgentb.CGenTbContainers}, {@link
 * com.fastpath.cslc.cslgen.cgentb.CGenTbRunContext}, {@link com.fastpath.cslc.cslgen.cgentb.CGenTbClassSpec}, {@link
 * com.fastpath.cslc.cslgen.cgentb.CGenTbSpecs}, {@link com.fastpath.cslc.cslgen.cgentb.CGenTbPreDeclOrder}, {@link
 * com.fastpath.cslc.cslgen.cgentb.CGenTbDeclEmit} (TG_DECLARATION + TG_INSTANCE_DECLARATION), {@link
 * com.fastpath.cslc.cslgen.cgentb.CGenTbCmdEmit} (TG_COMMAND_CALL + TG_INSTANCE_COMMAND_CALL), {@link
 * com.fastpath.cslc.cslgen.cgentb.CGenTbFileHeader}, {@link com.fastpath.cslc.cslgen.cgentb.CGenTbGeneratedFile}, {@link
 * com.fastpath.cslc.cslgen.cgentb.CGenTbStubBuild}, {@link
 * com.fastpath.cslc.cslgen.cgentb.CGenTbTestCounter}, {@link com.fastpath.cslc.cslgen.cgentb.CGenTbRegressionCtrl}, {@link
 * com.fastpath.cslc.cslgen.cgentb.CGenTbRunStub} ({@code runAfterLegacyRunChecksWithDirs},
 * {@code runAfterLegacyRunChecksWithReport}), {@link com.fastpath.cslc.cslgen.cgentb.CGenTbReport}, enums {@link
 * com.fastpath.cslc.cslgen.cgentb.CGenTbParamDecl}, {@link
 * com.fastpath.cslc.cslgen.cgentb.CGenTbTestGen}, {@link com.fastpath.cslc.cslgen.cgentb.CGenTbChapter}.
 */
package com.fastpath.cslc.cslgen.cgentb;
